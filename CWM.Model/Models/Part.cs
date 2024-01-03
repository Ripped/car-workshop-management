using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Part : Base
    {
        public string SerialNumber { get; set; } = string.Empty;
        public string Manufacturer { get; set; } = string.Empty;
        public string PartName { get; set; } = string.Empty;
        public byte[]? Image { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; } = string.Empty;
    }
}
