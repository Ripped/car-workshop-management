using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class City : Base
    {
        public string Name { get; set; } = string.Empty;
        public string ZipCode { get; set; } = string.Empty;
        public Country Country { get; set; } = new();
    }
}
