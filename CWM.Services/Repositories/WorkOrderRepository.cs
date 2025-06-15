using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Enums;
using CWM.Core.Models.Searches;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Repositories
{
    public class WorkOrderRepository : BaseRepository<Models.WorkOrder, Core.Models.WorkOrder, WorkOrderSearch>, IWorkOrderRepository
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
        protected override IQueryable<Models.WorkOrder> AddInclude(IQueryable<Models.WorkOrder> query, WorkOrderSearch? search = null)
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

            if (search.IncludePayment)
                query = query.Where(x=>x.Payment == false);

            return query;
        }

        public async Task<Core.Models.ReportWorkOrder> GetServiceReport(ReportWorkOrderSearch search)
        {
            var query = Context.WorkOrders.Include(x => x.Employee).Include(x => x.User).AsQueryable();


            if (search?.DateFrom.HasValue == true && search.DateTo.HasValue == true)
            {
                if (search.DateFrom.Value.Date >= search.DateTo.Value.Date)
                    throw new Exception("Date DATE_FROM must be lower than DATE_TO");

                query = query.Where(x => x.StartTime.Date >= search.DateFrom.Value.Date && x.StartTime.Date <= search.DateTo.Value.Date);
            }
            var listOfOrders = await query.ToListAsync();

            var groupServices = listOfOrders
                .GroupBy(group => group.StartTime.Date)
                .Select(y => new Core.Models.WorkOrderInfo()
                {
                    WorkOrderDate = y.Key,
                    ServiceReports = y.Select(n => new Core.Models.ListOfServiceReport()
                    {
                        StartTime = n.StartTime,
                        EndTime = n.EndTime,
                        Time = (n.EndTime - n.StartTime).TotalHours,
                        ServicePerformed = n.ServicePerformed,
                        Employee = Mapper.Map<Core.Models.Employee>(n.Employee),
                    }).ToList(),
                })
                .OrderBy(z => z.WorkOrders.OrderBy(x => x.TotalTime))
                .ToList();
            
            var list = new List<Core.Models.ListOfServiceReport>();


            foreach (var item in groupServices)
            {
                var employees = Context.Employees;
                
                foreach (var e in employees)
                {
                    //var listServiceTime = new List<Core.Models.ServiceTime>();
                    var t = item.ServiceReports.Where(x => x.Employee!.Id == e.Id).Select(y => y.ServicePerformed).Distinct().ToList();
                    foreach (var w in t)
                    {
                        double time = 0;
                        DateTime startTime = DateTime.Now;
                        var r = item.ServiceReports.Where(x => x.Employee!.Id == e.Id).Where(y=>y.ServicePerformed == w);
                        foreach (var x in r)
                        {
                            time += x.Time;
                            startTime = x.StartTime;
                        }

                        list.Add(new Core.Models.ListOfServiceReport()
                        {
                            TotalTime = time,
                            StartTime = startTime,
                            Employee = Mapper.Map<Core.Models.Employee>(e),
                            ServicePerformed = w,
                        });
                    }
                }
            }
            var listWorkOrder = new List<Core.Models.ListOfWorkOrder>();
            foreach (var item in groupServices)
            {

            }
            var groupServicesFinal = listOfOrders
                .GroupBy(group => group.StartTime.Date)
                .Select(y => new Core.Models.WorkOrderInfo()
                {
                    WorkOrderDate = y.Key,
                    ServiceReports = list
                })
                .OrderBy(z => z.WorkOrders.OrderBy(x => x.TotalTime))
                .ToList();
            
                double totalHours = 0;

                foreach(var item in groupServicesFinal)
                {
                    foreach(var s in item.ServiceReports){
                    totalHours += s.TotalTime;
                    }
                }

                var createReport = new Core.Models.ReportWorkOrder()
                {
                    TotalHours = totalHours,
                    WorkOrderInfo = groupServicesFinal,
                };

                return createReport;
            }

        public async Task<Core.Models.ReportWorkOrder> GetOrderReport(ReportWorkOrderSearch search)
        {
            var query = Context.WorkOrders.Include(x => x.User).AsQueryable();


            if (search?.DateFrom.HasValue == true && search.DateTo.HasValue == true)
            {
                if (search.DateFrom.Value.Date >= search.DateTo.Value.Date)
                    throw new Exception("Date DATE_FROM must be lower than DATE_TO");

                query = query.Where(x => x.StartTime.Date >= search.DateFrom.Value.Date && x.StartTime.Date <= search.DateTo.Value.Date);
            }
            var listOfOrders = await query.ToListAsync();

            var groupServices = listOfOrders
                .GroupBy(group => group.StartTime.Date)
                .Select(y => new Core.Models.WorkOrderInfo()
                {
                    WorkOrderDate = y.Key,
                    WorkOrders = y.Select(n => new Core.Models.ListOfWorkOrder()
                    {
                        WorkOrderId = n.Id,
                        OrderNumber = n.OrderNumber,
                        StartTime = n.StartTime,
                        EndTime = n.EndTime,
                        TotalSum = n.Total,
                        ServicePerformed = n.ServicePerformed,
                        User = Mapper.Map<Core.Models.User>(n.User),
                    }).ToList(),
                })
                .OrderBy(z => z.WorkOrders.OrderBy(x => x.TotalTime))
                .ToList();

            var list = new List<Core.Models.ListOfWorkOrder>();


            foreach (var item in groupServices)
            {
                var workOrders = item.WorkOrders.Distinct().ToList();
               
                foreach (var w in workOrders)
                {
                    double total = 0;

                    var r = Context.PartWorkOrder.Where(x => x.WorkOrder!.Id == w.WorkOrderId).Include(x => x.Part);
                    foreach (var x in r)
                    {
                        total += (double)x.Part!.Price;
                    }
                    total += (double)w.TotalSum;

                    list.Add(new Core.Models.ListOfWorkOrder()
                    {
                        OrderNumber = w.OrderNumber,
                        TotalSum = (decimal)total,
                        StartTime = w.StartTime,
                        User = Mapper.Map<Core.Models.User>(w.User),
                        ServicePerformed = w.ServicePerformed,
                    });
                    total = 0;
                    
                }
            }
            
            var groupServicesFinal = listOfOrders
                .GroupBy(group => group.StartTime.Date)
                .Select(y => new Core.Models.WorkOrderInfo()
                {
                    WorkOrderDate = y.Key,
                    WorkOrders = list,
                })
                .OrderBy(z => z.WorkOrders.OrderBy(x => x.TotalTime))
                .ToList();

            double totalSpent = 0;

            foreach (var item in groupServicesFinal)
            {
                foreach (var s in item.WorkOrders)
                {
                    totalSpent += (double)s.TotalSum;
                }
            }

            var createReport = new Core.Models.ReportWorkOrder()
            {

                WorkOrderInfo = groupServicesFinal,
                Total = (decimal)totalSpent
            };

            return createReport;
        }
    }
}
