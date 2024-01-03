using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Vehicle : Base
    {
        public string Chassis { get; set; } = string.Empty;
        public string Brand { get; set; } = string.Empty;
        public string Model { get; set; } = string.Empty;
        public int CubicCapacity { get; set; }
        public int Kilowatts { get; set; }
        public string Transmision { get; set; } = string.Empty;
        public DateTime ProductionDate { get; set; }
        public string Fuel { get; set; } = string.Empty;
        public VehicleServiceHistory ServiceHistory { get; set; } = new();
    }
}
