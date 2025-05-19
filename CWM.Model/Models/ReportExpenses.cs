using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class ReportExpenses
    {
        public int Total { get; set; }
        public Employee? Employee { get; set; }
        public ExpensesType ExpensesType { get; set; }
        public DateTime Date { get; set; }
    }
}
