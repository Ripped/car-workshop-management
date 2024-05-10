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
    public class AppointmentBlockedController : BaseCrudController<AppointmentBlocked, AppointmentBlockedSearch, AppointmentBlockedInsertUpdate, AppointmentBlockedInsertUpdate>
    {
        public AppointmentBlockedController(IMapper mapper, IAppointmentBlockedRepository appointmentBlockedRepository) : base(mapper, appointmentBlockedRepository) { }
    }
}
