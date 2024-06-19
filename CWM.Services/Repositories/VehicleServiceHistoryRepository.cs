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
    public class VehicleServiceHistoryRepository : BaseRepository<VehicleServiceHistory, Core.Models.VehicleServiceHistory, VehicleServiceHistorySearch>, IVehicleServiceHistoryRepository
    {
        public VehicleServiceHistoryRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.VehicleServiceHistory> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .VehicleServiceHistory
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.VehicleServiceHistory>(entity);
            }

            return new Core.Models.VehicleServiceHistory();
        }
        protected override IQueryable<VehicleServiceHistory> AddInclude(IQueryable<VehicleServiceHistory> query, VehicleServiceHistorySearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Description.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
