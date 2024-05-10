using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer.Query.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Formats.Asn1.AsnWriter;
using Appointment = CWM.Database.Models.Appointment;

namespace CWM.Database.Repositories
{
    public class AppointmentRepository : BaseRepository<Appointment, Core.Models.Appointment, AppointmentSearch>, IAppointmentRepository
    {
        public AppointmentRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.Appointment> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Appointments
                    .Include(x => x.AppointmentType)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.Appointment>(entity);
            }

            return new Core.Models.Appointment();
        }
        protected override IQueryable<Appointment> AddInclude(IQueryable<Appointment> query, AppointmentSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.ServiceName))
                query = query.Where(x => x.Description.ToLower().Contains(search.ServiceName.ToLower()));

            if (search.IncludeAppointmentType)
                query = query.Include(x => x.AppointmentType);

            return query;
        }
    }
}
