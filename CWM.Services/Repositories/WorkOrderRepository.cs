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
    public class WorkOrderRepository : BaseRepository<WorkOrder, Core.Models.WorkOrder, WorkOrderSearch>, IWorkOrderRepository
    {
        public WorkOrderRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.WorkOrder> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .WorkOrders
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.WorkOrder>(entity);
            }

            return new Core.Models.WorkOrder();
        }
        protected override IQueryable<WorkOrder> AddInclude(IQueryable<WorkOrder> query, WorkOrderSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Name))
                query = query.Where(x => x.Description.ToLower().Contains(search.Name.ToLower()));

            return query;
        }
    }
}
