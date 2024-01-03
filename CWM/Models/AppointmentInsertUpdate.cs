using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class AppointmentInsertUpdate
    {
        public Service ServicePerformed { get; set; }
        public string Description { get; set; } = string.Empty;
        public DateTime? AppointmentDate { get; set; }
        [Required]
        public int? UserId { get; set; }
    }
}
