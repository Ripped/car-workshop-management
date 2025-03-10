using AutoMapper;
using CWM.Core.Models;
using CWM.SMTP.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace CWM.SMTP.Controllers
{
    [ApiController]
    public class EmailController(IEmailService emailService) : ControllerBase
    {
        private readonly IEmailService EmailService = emailService;

        /*[HttpGet("ErrorHandler")]
        public async Task Test(string message)
            => await EmailService.SendErrorMailAsync(message);*/

        [HttpGet("EmailNotifier")]
        public async Task Notifier([FromQuery]Appointment message)
            => await EmailService.SendEmailMessage(message);
        
    }
}
