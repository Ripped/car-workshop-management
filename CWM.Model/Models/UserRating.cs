using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class UserRating : Base
    {
        public double ProductRating { get; set; }
        public User? User { get; set; } = new();
        public Part? Part { get; set; } = new();
    }
}
