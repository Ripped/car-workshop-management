using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class UserLogin
    {
        public required string Username { get; set; }
        public required string Password { get; set; }
    }
}
