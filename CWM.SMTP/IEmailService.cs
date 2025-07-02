
namespace CWM.SMTP
{
    public interface IEmailService
    {
        void SendEmail(string email, string message);
    }
}
