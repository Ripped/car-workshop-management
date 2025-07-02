using CWM.Core.Models.Searches;
using CWM.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Repositories
{
    public interface IAppointmentRepository : IBaseRepository<Appointment, AppointmentSearch> {
        Task<Appointment> Update(int id, Appointment model);
    }
}

