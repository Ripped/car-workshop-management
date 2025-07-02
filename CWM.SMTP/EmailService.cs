
using MimeKit;
using MailKit.Net.Smtp;
using MailKit.Security;
using CWM.SMTP;
using CWM.SMTP.Models;
using Microsoft.Extensions.Options;

public class EmailService : IEmailService
{
    private readonly IConfiguration _configuration;
    private readonly EmailConfiguration _emailConfiguration;

    public EmailService(IConfiguration configuration, IOptions<EmailConfiguration> emailConfiguration)
    {
        _configuration = configuration;
        _emailConfiguration = emailConfiguration.Value;
    }

    public void SendEmail(string email, string message)
    {
        var emailMessage = new MimeMessage();

        emailMessage.From.Add(new MailboxAddress("Restorante Reservation Service", _emailConfiguration.SmtpMail));
        emailMessage.To.Add(new MailboxAddress("Customer", email));
        emailMessage.Subject = "New Reservation Added";
        emailMessage.Body = new TextPart("plain")
        {
            Text = message
        };

        using var client = new SmtpClient();
        try
        {
            client.Connect("smtp.gmail.com", 587, SecureSocketOptions.StartTls);

            client.Authenticate(_emailConfiguration.SmtpMail, _emailConfiguration.SmtpPass);

            client.Send(emailMessage);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred while sending email to {email}: {ex.Message}");
        }
        finally
        {
            client.Disconnect(true);
            client.Dispose();
        }
    }
}
