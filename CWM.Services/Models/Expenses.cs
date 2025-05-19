using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    public class Expenses
    {
        public int Id { get; set; }
        public int TotalAmount { get; set; }
        public DateTime Date { get; set; }
        public ExpensesType ExpensesType { get; set; }
        public string Description { get; set; } = string.Empty;

        [ForeignKey("Employees")]
        public int EmployeeId { get; set; }
        public virtual Employee? Employee { get; set; }
    }
}
