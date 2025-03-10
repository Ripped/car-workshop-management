using CWM.Core.Models;

namespace CWM.SMTP.Interfaces
{
    public interface IEmailService
    {
        Task<Appointment> SendEmailMessage(Appointment notifier);
    }
}
