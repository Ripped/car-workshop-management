using Microsoft.AspNetCore.Mvc;

namespace CWM.SMTP.Controllers
{
    [ApiController]
    public class EmailController(IEmailService emailService) : ControllerBase
    {
        private readonly IEmailService EmailService = emailService;

        [HttpGet("EmailNotifier")]
        public void Notifier(string email, string message)
            => EmailService.SendEmail(email, message);

    }
}
