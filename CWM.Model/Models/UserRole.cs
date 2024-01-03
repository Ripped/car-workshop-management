using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class UserRole : Base
    {
        public int Id { get; set; }

        public User User { get; set; } = new();

        public Role Role { get; set; } = Role.Employee;
    }
}
