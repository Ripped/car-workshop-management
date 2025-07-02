using System.ComponentModel.DataAnnotations;

namespace CWM.Models
{
    public class UserRatingInsertUpdate
    {
        public double ProductRating { get; set; }

        [Required]
        public int? UserId { get; set; }
        [Required]
        public int? PartId { get; set; }
    }
}
