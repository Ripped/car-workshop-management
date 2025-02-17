using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class VehicleServiceHistory : Base
    {
        public DateTime? ServiceDate { get; set; }
        public Service ServiceType { get; set; }
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;
        public Vehicle? Vehicle { get; set; } = new();
        public Employee? Employee { get; set; } = new();
        public User? User { get; set; } = new();
    }
}
