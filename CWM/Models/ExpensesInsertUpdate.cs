using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class ExpensesInsertUpdate
    {
        public decimal TotalAmount { get; set; }
        public DateTime? Date { get; set; }
        public string Description { get; set; } = string.Empty;

        [Required]
        public int? EmployeeId { get; set; }
    }
}
