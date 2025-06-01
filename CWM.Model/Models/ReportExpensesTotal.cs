using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class ReportExpensesTotal
    {
        public int Total { get; set; }
        public List<ReportExpenses> ReportExpenses { get; set; } = new List<ReportExpenses> { };
    }
}
