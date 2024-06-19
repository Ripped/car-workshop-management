using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class WorkOrderInsertUpdate
    {
        public int OrderNumber { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public GarageBox GarageBox { get; set; }
        public string Concerne { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;

        [Required]
        public int? VehicleId { get; set; } = new();
        [Required]
        public int? AppointmentId { get; set; } = new();
        [Required]
        public int? UserId { get; set; } = new();
    }
}
