using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class PartWorkOrder : Base
    {
        public DateTime? ServiceDate { get; set; }
        public Vehicle? Vehicle { get; set; } = new();
        public Part? Part { get; set; } = new();
        public WorkOrder? WorkOrder { get; set; } = new();
    }
}
