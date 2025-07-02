using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class AppointmentInsertUpdate
    {
        public string Description { get; set; } = string.Empty;
        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }

        [Required]
        public int? UserId { get; set; }
     
        [Required]
        public int? AppointmentTypeId { get; set; }

        [Required]
        public int? VehicleId { get; set; }

    }
}
