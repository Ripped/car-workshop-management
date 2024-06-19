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
    public class VehicleRepository : BaseRepository<Vehicle, Core.Models.Vehicle, VehicleSearch>, IVehicleRepository
    {
        public VehicleRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.Vehicle> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Vehicles
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.Vehicle>(entity);
            }

            return new Core.Models.Vehicle();
        }
        protected override IQueryable<Vehicle> AddInclude(IQueryable<Vehicle> query, VehicleSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Chassis.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
