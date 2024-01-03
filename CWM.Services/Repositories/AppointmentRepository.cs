using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class AppointmentRepository : BaseRepository<Models.Appointment, Core.Models.Appointment, AppointmentSearch>, IAppointmentRepository
    {
        public AppointmentRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        protected override IQueryable<Appointment> AddInclude(IQueryable<Appointment> query, AppointmentSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Description.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
