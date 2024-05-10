using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class AppointmentTypeRepository : BaseRepository<AppointmentType, Core.Models.AppointmentType, AppointmentTypeSearch>, IAppointmentTypeRepository
    {
        public AppointmentTypeRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

        protected override IQueryable<AppointmentType> AddInclude(IQueryable<AppointmentType> query, AppointmentTypeSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Name.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
