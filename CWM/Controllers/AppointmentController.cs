using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Models;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController : BaseCrudController<Appointment, AppointmentSearch, AppointmentInsertUpdate, AppointmentInsertUpdate>
    {
        public AppointmentController(IMapper mapper, IAppointmentRepository appointmentRepository) : base(mapper, appointmentRepository) { }
    }
}
