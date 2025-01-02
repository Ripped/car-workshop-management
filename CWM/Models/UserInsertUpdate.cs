using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class UserInsertUpdate
    {
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public Gender Gender { get; set; }
        public DateTime? BirthDate { get; set; }
        public DateTime? CreateDate { get; set; }
        public byte[]? Image { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public string OfficePhone { get; set; } = string.Empty;
        public List<Role> Roles { get; set; } = new();

        [Required]
        public int? CityId { get; set; }

        [Required]
        public int? CountryId { get; set; }
    }
}
