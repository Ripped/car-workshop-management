using CWM.Core.Interfaces.Services;
using CWM.Core.Models;
using CWM.Core.Models.Configurations;
using EasyNetQ;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using RabbitMQ.Client;
using System.Text;

namespace CWM.RabbitMQ
{
    public class EmailService(
    IOptions<RabbitMQConfiguration> rabbitMQConfiguration,
    ILogger<EmailService> logger)
    : IEmailService
    {
    private readonly RabbitMQConfiguration RabbitMQConfiguration = rabbitMQConfiguration.Value;
    private readonly ILogger<EmailService> Logger = logger;
    private IConnection? Connection;
        public async Task<Appointment> SendEmailMessage(Appointment message)
        {
            var notification = new AppointmentNotifier
            {
                Description = message.Description,
                StartDate = message.StartDate,
                EndDate = message.EndDate,
                Vehicle = message.Vehicle?.ToString(),
                User = message.User?.ToString()
            };

            try
            {
                ConnectionFactory factory = new ConnectionFactory
                {
                    HostName = RabbitMQConfiguration.Host,
                    Port = RabbitMQConfiguration.Port,
                    UserName = RabbitMQConfiguration.User,
                    Password = RabbitMQConfiguration.Password
                };

                using var connection = factory.CreateConnection();
                using var channel = connection.CreateModel();

                channel.ExchangeDeclare("Email", ExchangeType.Fanout);

                channel.BasicPublish(
                    exchange: "Email",
                    routingKey: string.Empty,
                    body: Encoding.UTF8.GetBytes(message.ToJson())
                );
                var bus = RabbitHutch.CreateBus("host=localhost");
                await bus.PubSub.PublishAsync(message);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "SendMailAsync");
            }
            return message;
        }
        
    }
}
