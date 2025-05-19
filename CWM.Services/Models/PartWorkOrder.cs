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
    public class PartWorkOrder
    {
        [Key]
        public int Id { get; set; }
        public decimal TotalAmount { get; set; }
        public DateTime ServiceDate { get; set; }

        [ForeignKey("Vehicle")]
        public int? VehicleId { get; set; }
        public virtual Vehicle? Vehicle { get; set; }

        [ForeignKey("Parts")]
        public int? PartId { get; set; }
        public virtual Part? Part { get; set; }

        [ForeignKey("WorkOrder")]
        public int? WorkOrderId { get; set; }
        public virtual WorkOrder? WorkOrder { get; set; }
    }
}
