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
    [Table("VehicleServiceHistory")]
    public class VehicleServiceHistory
    {
        [Key]
        public int Id { get; set; }

        public DateTime ServiceDate { get; set; }
        public Service ServiceType { get; set; }
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;

        [ForeignKey("Vehicle")]
        public int? VehicleId { get; set; }
        public virtual Vehicle? Vehicle { get; set; }

        [ForeignKey("User")]
        public int? UserId { get; set; }
        public virtual User? User { get; set; }

        [ForeignKey("Employee")]
        public int? EmployeeId { get; set; }
        public virtual Employee? Employee { get; set; }
    }
}
