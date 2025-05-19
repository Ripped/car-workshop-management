using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class ExpensesSearch : BaseSearch
    {
        public DateTime? ExpensesDate { get; set; }
        public bool IncludeEmployee { get; set; }
        public int? EmployeeId { get; set; }
        public string? Description { get; set; }
    }
}
