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
        public string OrderNumber { get; set; } = string.Empty;
        public decimal Total {  get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public GarageBox GarageBox { get; set; }
        public Service ServicePerformed { get; set; }
        public string Concerne { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;
        public Vehicle? Vehicle { get; set; } = new();
        public User? User { get; set; } = new();
        public Appointment? Appointment { get; set; } = new();
        public Employee? Employee { get; set; } = new();
    }
}
