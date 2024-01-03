using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("Vehicles")]
    public class Vehicle
    {
        [Key]
        public int Id { get; set; }

        public string Chassis {  get; set; } = string.Empty;
        public string Brand { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int CubicCapacity { get; set; }
        public int Kilowatts { get; set; }
        public string Transmision { get; set; } = string.Empty;
        public DateTime ProductionDate { get; set; }
        public string Fuel { get; set; } = string.Empty;

        [ForeignKey("User")]
        public int UserId { get; set; }
        public virtual User? User { get; set; }

        [ForeignKey("VehicleServiceHistory")]
        public int? VehicleServiceHistoryId { get; set; }
        public virtual VehicleServiceHistory? ServiceHistory { get; set; }


        // Relations
        public virtual ICollection<WorkOrder> WorkOrders { get; set; } = new List<WorkOrder>();
    }
}
