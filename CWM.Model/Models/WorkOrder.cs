using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class WorkOrder : Base
    {
        public DateTime OrderDate { get; set; }
        public int OrderNumber { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public GarageBox GarageBox { get; set; }
        public string Concerne { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;
        public Vehicle Vehicle { get; set; } = new();
    }
}
