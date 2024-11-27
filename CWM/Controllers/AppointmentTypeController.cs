using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentTypeController : BaseCrudController<AppointmentType, AppointmentTypeSearch, AppointmentTypeInsertUpdate, AppointmentTypeInsertUpdate>
    {
        public AppointmentTypeController(IMapper mapper, IAppointmentTypeRepository appointmentTypeRepository) : base(mapper, appointmentTypeRepository) { }
    }
}
