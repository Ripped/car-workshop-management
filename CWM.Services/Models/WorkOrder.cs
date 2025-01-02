using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("WorkOrders")]
    public class WorkOrder
    {
        [Key]
        public int Id { get; set; }
        public string OrderNumber { get; set; } = string.Empty;
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public GarageBox GarageBox { get; set; }
        public Service ServicePerformed { get; set; }
        public string Concerne { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;

        [ForeignKey("Appointment")]
        public int? AppointmentId { get; set; }
        public virtual Appointment? Appointment { get; set; }

        [ForeignKey("Vehicle")]
        public int? VehicleId { get; set; }
        public virtual Vehicle? Vehicle { get; set; }

        [ForeignKey("User")]
        public int? UserId { get; set; }
        public virtual User? User { get; set; }
    }
}
