using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class PartWorkOrderInsertUpdate
    {
        public DateTime? ServiceDate { get; set; }

        [Required]
        public int? VehicleId { get; set; }
        [Required]
        public int? PartId { get; set; }
        [Required]
        public int? WorkOrderId { get; set; }
    }
}
