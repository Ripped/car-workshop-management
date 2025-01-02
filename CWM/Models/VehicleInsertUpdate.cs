using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class VehicleInsertUpdate
    {
        public string Chassis { get; set; } = string.Empty;
        public string Brand { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int CubicCapacity { get; set; }
        public int Kilowatts { get; set; }
        public string Transmision { get; set; } = string.Empty;
        public DateTime? ProductionDate { get; set; }
        public string Fuel { get; set; } = string.Empty;

        [Required]
        public int? UserId { get; set; }
    }
}
