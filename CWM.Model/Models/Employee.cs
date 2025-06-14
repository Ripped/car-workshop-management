using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Employee : Base
    {
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public DateTime BirthDate { get; set; }
        public string Username {  get; set; } = string.Empty;
        public byte[]? Image { get; set; }
        public City City { get; set; } = new();
        public Country Citizenship { get; set; } = new();
        public string Email { get; set; } = string.Empty;
        public string Adress { get; set; } = string.Empty;
    }
}
