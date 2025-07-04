using AutoMapper;
using CWM.Core.Interfaces.Repositories;
using CWM.Core.Models;
using CWM.Core.Models.Enums;
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
    public class ExpensesRepository : BaseRepository<Models.Expenses, Core.Models.Expenses, ExpensesSearch>, IExpensesRepository
    {
        public ExpensesRepository(CWMContext context, IMapper mapper) : base(context, mapper) { }
        public override async Task<Core.Models.Expenses> GetAsync(int id)
        {
            var isNew = id == 0;

            if (!isNew)
            {
                var entity = await Context
                    .Expenses
                    .Include(x => x.Employee)
                    .SingleOrDefaultAsync(x => x.Id == id);

                return Mapper.Map<Core.Models.Expenses>(entity);
            }

            return new Core.Models.Expenses();
        }

        protected override IQueryable<Models.Expenses> AddInclude(IQueryable<Models.Expenses> query, ExpensesSearch? search = null)
        {
            if (search is null)
                return base.AddInclude(query, search);

            if (!string.IsNullOrWhiteSpace(search.Description))
                query = query.Where(x =>
                    x.Description.ToLower().Contains(search.Description.ToLower())
                );

            if (search.IncludeEmployee)
                query = query.Include(x => x.Employee);

            if (search.EmployeeId > 0)
                query = query.Where(x => x.Employee!.Id == search.EmployeeId);

            if (search.ExpensesDate != null)
                query = query.Where(x => x.Date == search.ExpensesDate);

            return query;
        }

        public async Task<Core.Models.ReportExpensesTotal> GetFinanceReport(ReportWorkOrderSearch search)
        {
            var query = Context.Expenses.Include(x => x.Employee).AsQueryable();


            if (search?.DateFrom.HasValue == true && search.DateTo.HasValue == true)
            {
                if (search.DateFrom.Value.Date >= search.DateTo.Value.Date)
                    throw new Exception("Date DATE_FROM must be lower than DATE_TO");

                query = query.Where(x => x.Date.Date >= search.DateFrom.Value.Date && x.Date.Date <= search.DateTo.Value.Date);
            }
            var listOfOrders = await query.ToListAsync();

            var list = new List<Core.Models.ReportExpenses>();

            var employees = Context.Employees;

            var r = listOfOrders.Select(x => x.ExpensesType).Distinct().ToList();

            foreach (var item in r)
            {
                var e = listOfOrders.Where(x => x.ExpensesType == item).ToList();
                int totalExpenses = 0;

                foreach (var q in r)
                {
                    foreach (var x in e)
                    {

                        if (x.ExpensesType == q)
                        {
                            totalExpenses += x.TotalAmount;
                        }
                    }
                    if (totalExpenses > 0)
                    {
                        list.Add(new Core.Models.ReportExpenses()
                        {
                            Total = totalExpenses,
                            //Employee = Mapper.Map<Core.Models.Employee>(item),
                            ExpensesType = q,
                        });
                        totalExpenses = 0;
                    }
                }
            }
            int total = 0;
            foreach (var item in list)
            {
                total += item.Total;
            }
            var createReport = new Core.Models.ReportExpensesTotal()
            {
                Total = total,
                ReportExpenses = list,
            };

            return createReport;
        }
    }
}

