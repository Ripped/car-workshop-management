using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class EmployeeInsertUpdate
    {
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Mobile { get; set; } = string.Empty;
        public DateTime? BirthDate { get; set; }
        public string Email { get; set; } = string.Empty;
        public string Adress { get; set; } = string.Empty;

        [Required]
        public int? CityId { get; set; }

        [Required]
        public int? CountryId { get; set; }
    }
}
