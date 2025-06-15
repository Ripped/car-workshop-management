using CWM.Core.Models;
using CWM.SMTP.Interfaces;
using CWM.SMTP.Models;
using mailslurp.Api;
using mailslurp.Client;
using mailslurp.Model;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using Serilog;
using System.Diagnostics;
using System.Net.Mail;
using System.Net;
using System.Text;

namespace CWM.SMTP.Services
{
    public class EmailService : IEmailService
    {
        private readonly RabbitMQConfiguration RabbitMQConfiguration;
        private readonly MailSlurpConfiguration MailSlurpConfiguration;
        private readonly EmailConfiguration EmailConfiguration;
        private readonly ILogger<EmailService> Logger;
        private IConnection? Connection;
        private IChannel? Channel;

        public EmailService(
            IOptions<RabbitMQConfiguration> rabbitMQConfiguration,
            IOptions<MailSlurpConfiguration> mailSlurpConfiguration,
            IOptions<EmailConfiguration> emailConfiguration,
            ILogger<EmailService> logger)
        {
            RabbitMQConfiguration = rabbitMQConfiguration.Value;
            MailSlurpConfiguration = mailSlurpConfiguration.Value;
            EmailConfiguration = emailConfiguration.Value;
            Logger = logger;
            Task task = Connect();
        }

        private async Task Connect()
        {
            try
            {
                ConnectionFactory factory = new ConnectionFactory
                {
                    HostName = RabbitMQConfiguration.Host,
                    Port = RabbitMQConfiguration.Port,
                    UserName = RabbitMQConfiguration.User,
                    Password = RabbitMQConfiguration.Password
                };

                Connection = await factory.CreateConnectionAsync();
                Channel = await Connection.CreateChannelAsync();

                await Channel.ExchangeDeclareAsync("Email", ExchangeType.Fanout);

                var queueName = await Channel
                    .QueueDeclareAsync(
                        durable: true,
                        exclusive: false,
                        autoDelete: false)
                    ;

                await Channel.QueueBindAsync(
                    queue: queueName,
                    exchange: "Email",
                    routingKey: string.Empty
                );

                var consumer = new AsyncEventingBasicConsumer(Channel);
                consumer.ReceivedAsync += SendErrorMailEventHandler;

                await Channel.BasicConsumeAsync(
                    queue: queueName,
                    autoAck: true,
                    consumer: consumer
                );
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "EmailService");
            }
        }

        private async Task SendErrorMailEventHandler(object? model, BasicDeliverEventArgs eventArgs)
        {
            if (Debugger.IsAttached) return;

            var body = eventArgs.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);


        }

        public async Task<Appointment> SendEmailMessage(Appointment reservation)
        {
            var notification = new AppointmentNotifier
            {
                Description = reservation.Description,
                StartDate = reservation.StartDate,
                EndDate = reservation.EndDate,
                Vehicle = reservation.Vehicle?.ToString(),
               User = reservation.User?.ToString()
            };


            String message = notification.Description;
            try
            {
                var configuration = new Configuration();
                configuration.ApiKey.Add("x-api-key", MailSlurpConfiguration.ApiKey);

                var inboxController = new InboxControllerApi(configuration);

                var sendEmailOptions = new SendEmailOptions
                {
                    UseInboxName = true,
                    Subject = "CWM Reservation Message",
                    Body = message,
                    IsHTML = true,
                    To = MailSlurpConfiguration
                        .SupportEmails
                        .Split(',')
                        .ToList()
                };

                await inboxController.SendEmailAndConfirmAsync(Guid.Parse(MailSlurpConfiguration.InboxId), sendEmailOptions);
                Logger.LogInformation("Email sent to " + MailSlurpConfiguration.SupportEmails + ".");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Appointment Reservation Mail notification");
            }
            return reservation;
        }

        public async Task SendEmailAsync(string email, string subject, Appointment appointment)
        {
            var notification = new AppointmentNotifier
            {
                Description = appointment.Description,
                StartDate = appointment.StartDate,
                EndDate = appointment.EndDate,
                Vehicle = appointment.Vehicle?.ToString(),
                User = appointment.User?.ToString()
            };

            String message = notification.Description;

            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(EmailConfiguration.OutlookMail, EmailConfiguration.OutlookPass)
            };

            await client.SendMailAsync(new MailMessage(from: EmailConfiguration.OutlookMail,to: email,subject, message));
        }
    }
}
