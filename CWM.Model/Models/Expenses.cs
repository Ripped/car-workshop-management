using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Expenses : Base
    {
        public int TotalAmount { get; set; }
        public DateTime Date { get; set; }
        public string Description { get; set; } = string.Empty;
        public ExpensesType ExpensesType { get; set; }
        public Employee Employee { get; set; } = new();
    }
}
