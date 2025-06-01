using CWM.Core.Models.Searches;
using CWM.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Repositories
{
    public interface IExpensesRepository : IBaseRepository<Expenses, ExpensesSearch> {
        Task<Core.Models.ReportExpensesTotal> GetFinanceReport(ReportWorkOrderSearch search);
    }
}
