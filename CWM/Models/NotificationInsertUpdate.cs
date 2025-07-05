using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class NotificationInsertUpdate
    {
        public string Description { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;

        [Required]
        public int? UserId { get; set; }
    }
}
