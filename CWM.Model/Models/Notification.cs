using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Notification : Base
    {
        public string Description { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public User? User { get; set; } = new();
    }
}
