using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class UserRoleInsertUpdate
    {
        [Required]
        public int? UserId { get; set; }

        public Role Role { get; set; }
    }
}
