using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Interfaces.Services;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Database.Repositories;
using CWM.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController(IMapper mapper, IAppointmentRepository appointmentRepository, IEmailService emailService) : 
        BaseCrudController<Appointment, AppointmentSearch, AppointmentInsertUpdate, AppointmentInsertUpdate>(mapper, appointmentRepository)
    {
        private readonly IEmailService EmailService = emailService;

        [HttpPost]
        public override async Task<Appointment> Insert([FromBody] AppointmentInsertUpdate insert)
            => await EmailService.SendEmailMessage(Mapper.Map<Appointment>(insert));
    }
}
