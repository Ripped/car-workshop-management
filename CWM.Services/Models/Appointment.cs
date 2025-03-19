using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CWM.Database.Models
{
    [Table("Appointments")]

    public class Appointment
    {
        [Key]
        public int Id { get; set; }

        public string Description { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

       [ForeignKey("AppointmentType")]
        public int? AppointmentTypeId { get; set; }
        public virtual AppointmentType? AppointmentType { get; set; }

        [ForeignKey("User")]
        public int? UserId { get; set; }
        public virtual User? User { get; set; }

        [ForeignKey("Vehicle")]
        public int? VehicleId { get; set; }
        public virtual Vehicle? Vehicle { get; set; }

        // Relations
        public virtual ICollection<AppointmentBlocked> AppointmentBlocked { get; set; } = new List<AppointmentBlocked>();

    }
}
