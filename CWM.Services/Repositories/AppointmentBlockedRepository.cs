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
    public class AppointmentBlockedRepository : BaseRepository<AppointmentBlocked, Core.Models.AppointmentBlocked, AppointmentBlockedSearch>, IAppointmentBlockedRepository
    {
        public AppointmentBlockedRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.AppointmentBlocked> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context.AppointmentBlocked.SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.AppointmentBlocked>(entity);
            }
            return new Core.Models.AppointmentBlocked();
        }

        protected override IQueryable<AppointmentBlocked> AddInclude(IQueryable<AppointmentBlocked> query, AppointmentBlockedSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);
            if (search.BlockedDate != null)
                query = query.Where(x => x.BlockedDate == search.BlockedDate);

            return query;
        }
    }
}
