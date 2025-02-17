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
                    .Include(x => x.Vehicle)
                    .Include(x => x.User)
                    .Include(x => x.Appointment)
                    .Include(x => x.Employee)
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
                query = query.Where(x => x.OrderNumber.ToLower().Contains(search.Name.ToLower()));

            if (!string.IsNullOrWhiteSpace(search.EmployeeUsername))
                query = query.Where(x => x.Employee!.Username.ToLower().Contains(search.EmployeeUsername.ToLower()));

            if (search.AppointmentId > 0)
                query = query.Where(x => x.Appointment!.Id == search.AppointmentId);

            if (search.IncludeVehicle)
                query = query.Include(x => x.Vehicle);

            return query;
        }
    }
}
