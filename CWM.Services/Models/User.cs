using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("Users")]
    public class User
    {
        [Key]
        public int Id { get; set; }

        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public Gender Gender { get; set; }
        public DateTime BirthDate { get; set; }
        public DateTime CreateDate { get; set; }

        [ForeignKey("City")]
        public int? CityId { get; set; }
        public virtual City? City { get; set; }

        [ForeignKey("Citizenship")]
        public int? CitizenshipId { get; set; }
        public virtual Country? Citizenship { get; set; }

        public byte[]? Image { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string OfficePhone { get; set; } = string.Empty;


        // Relations
        public virtual ICollection<UserRole> Roles { get; set; } = new List<UserRole>();
        public virtual ICollection<Vehicle> Vehicles { get; set; } = new List<Vehicle>();
        public virtual ICollection<WorkOrder> WorkOrders { get; set; } = new List<WorkOrder>();
    }
}
