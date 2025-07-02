using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;
using CWM.SMTP.Models;
using CWM.SMTP;
using Microsoft.Extensions.Options;

public class EmailConsumer : IEmailConsumer
{
    private readonly IModel? _channel;
    private readonly IConfiguration _configuration;
    private readonly IEmailService _emailService;
    private readonly RabbitMQConfiguration _rabbitMQConfiguration;

    public EmailConsumer(IConfiguration configuration, IEmailService emailService, IOptions<RabbitMQConfiguration> rabbitMQConfiguration)
    {
        _configuration = configuration;
        _emailService = emailService;
        _rabbitMQConfiguration = rabbitMQConfiguration.Value;
        try {
            var factory = new ConnectionFactory
            {
                HostName = _rabbitMQConfiguration.Host,
                UserName = _rabbitMQConfiguration.User,
                Password = _rabbitMQConfiguration.Password,
                Port = _rabbitMQConfiguration.Port,

            };
            var connection = factory.CreateConnection();
            _channel = connection.CreateModel();

            _channel.QueueDeclare(queue: "reservationQueue",
                                 durable: false,
                                 exclusive: false,
                                 autoDelete: false,
                                 arguments: null);

            var consumer = new EventingBasicConsumer(_channel);
            consumer.Received += (model, ea) =>
            {
                var body = ea.Body.ToArray();
                var message = Encoding.UTF8.GetString(body);
                Console.WriteLine(" [x] Received {0}", message);
                var email = ExtractEmailFromMessage(message);
                Console.WriteLine(" [x] Received {0}", email);
                _emailService.SendEmail(email, message);
            };
            _channel.BasicConsume(queue: "reservationQueue",
                                 autoAck: true,
                                 consumer: consumer);
        }
        catch (Exception ex) { Console.WriteLine(ex.Message); }
    }

    public void SendEmail()
    {
        try
        {
            _channel.QueueDeclare(queue: "reservationQueue",
                             durable: false,
                             exclusive: false,
                             autoDelete: false,
                             arguments: null);

            var consumer = new EventingBasicConsumer(_channel);
            consumer.Received += (model, ea) =>
            {
                var body = ea.Body.ToArray();
                var message = Encoding.UTF8.GetString(body);
                Console.WriteLine(" [x] Received {0}", message);
                var email = ExtractEmailFromMessage(message);
                Console.WriteLine(" [x] Received {0}", email);
                _emailService.SendEmail(email, message);
            };
            _channel.BasicConsume(queue: "reservationQueue",
                                 autoAck: true,
                                 consumer: consumer);
        }
        catch (Exception ex) { Console.WriteLine(ex.Message); }
    }

    private string ExtractEmailFromMessage(string message)
    {
        var parts = message.Split(' ');
        return parts.Length > 3 ? parts[3] : string.Empty;
    }
}