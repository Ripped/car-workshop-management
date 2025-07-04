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
    public class AppointmentController(IMapper mapper, IAppointmentRepository appointmentRepository) : 
        BaseCrudController<Appointment, AppointmentSearch, AppointmentInsertUpdate, AppointmentInsertUpdate>(mapper, appointmentRepository)
    {
        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public override async Task<Appointment> Update(int id, [FromBody] AppointmentInsertUpdate update)
           => await appointmentRepository.Update(id, Mapper.Map<Appointment>(update));
        
    }
}
