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
    public class PartWorkOrderRepository : BaseRepository<PartWorkOrder, Core.Models.PartWorkOrder, PartWorkOrderSearch>, IPartWorkOrderRepository
    {
        public PartWorkOrderRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }

        public override async Task<Core.Models.PartWorkOrder> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .PartWorkOrder
                    .Include(x => x.Part)
                    .Include(x => x.WorkOrder)
                    .Include(x => x.Vehicle)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.PartWorkOrder>(entity);
            }

            return new Core.Models.PartWorkOrder();
        }

        protected override IQueryable<PartWorkOrder> AddInclude(IQueryable<PartWorkOrder> query, PartWorkOrderSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (search.IncludePart)
                query = query.Include(x => x.Part);

            if (search.IncludeWorkOrder)
                query = query.Include(x => x.WorkOrder);

            if (search.VehicleId > 0)
                query = query.Where(x => x.Vehicle!.Id == search.VehicleId);

            if (search.UserId > 0)
                query = query.Where(x => x.Vehicle!.UserId == search.UserId);

            if (search.WorkOrderId > 0)
                query = query.Where(x => x.WorkOrder!.Id == search.WorkOrderId);

            if (search.ServiceDate != null)
                query = query.Where(x => x.ServiceDate == search.ServiceDate);

            return query;
        }
    }
}
