using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class User : Base
    {
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public Gender Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime CreateDate { get; set; }
        public City City { get; set; } = new();
        public Country Citizenship { get; set; } = new();
        public byte[]? Image { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string OfficePhone { get; set; } = string.Empty;
        public List<Role> Roles { get; set; } = new();
    }
}
