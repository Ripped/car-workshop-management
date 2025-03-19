using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("UserRatings")]
    public class UserRating
    {
        [Key]
        public int Id { get; set; }
        public double ProductRating { get; set; }

        [ForeignKey("Users")]
        public int? UserId { get; set; }
        public virtual User? User { get; set; }

        [ForeignKey("Parts")]
        public int? PartId { get; set; }
        public virtual Part? Part { get; set; }
    }
}
