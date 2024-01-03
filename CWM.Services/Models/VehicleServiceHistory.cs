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

        [ForeignKey("Vehicle")]
        public int VehicleId { get; set; }
        public virtual Vehicle? Vehicle { get; set; }


        // Relations
        public virtual ICollection<WorkOrder> WorkOrders { get; set; } = new List<WorkOrder>();
        public virtual ICollection<Part> Parts { get; set; } = new List<Part>();
    }
}
