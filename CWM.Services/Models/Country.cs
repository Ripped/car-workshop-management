using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("Countries")]
    public class Country
    {
        [Key]
        public int Id { get; set; }

        public string Name { get; set; } = string.Empty;


        // Relations
        public virtual ICollection<City> Cities { get; set; } = new List<City>();
        public virtual ICollection<User> Users { get; set; } = new List<User>();
    }
}
