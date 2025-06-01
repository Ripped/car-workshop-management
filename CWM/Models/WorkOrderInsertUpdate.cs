using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class WorkOrderInsertUpdate
    {
        public string OrderNumber { get; set; } = string.Empty;
        public decimal Total {  get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public GarageBox GarageBox { get; set; }
        public Service ServicePerformed { get; set; }
        public string Concerne { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;

        [Required]
        public int? VehicleId { get; set; }
        [Required]
        public int? AppointmentId { get; set; }
        [Required]
        public int? UserId { get; set; }
        [Required]
        public int? EmployeeId { get; set; }
    }
}
