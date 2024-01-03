using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CWM.Core.Models.Enums;

namespace CWM.Database.Models
{
    [Table("UserRoles")]
    public class UserRole
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("User")]
        public int UserId { get; set; }
        public virtual User? User { get; set; }

        public Role Role { get; set; } = Role.User;
    }
}
