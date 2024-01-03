using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class CountryInsertUpdate
    {
        [Required]
        public string Name { get; set; } = string.Empty;
    }
}
