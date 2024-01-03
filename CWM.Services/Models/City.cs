using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics.Metrics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    [Table("Cities")]
    public class City
    {
        [Key]
        public int Id { get; set; }

        public string Name { get; set; } = string.Empty;
        public string ZipCode { get; set; } = string.Empty;

        [ForeignKey("Country")]
        public int CountryId { get; set; }
        public virtual Country? Country { get; set; }
    }
}
