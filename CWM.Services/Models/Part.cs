using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CWM.Database.Models
{
    [Table("Parts")]
    public class Part
    {
        [Key]
        public int Id { get; set; }

        public string SerialNumber { get; set; } = string.Empty;
        public string Manufacturer { get; set; } = string.Empty;
        public string PartName { get; set; } = string.Empty;
        public byte[]? Image { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; } = string.Empty;

        public virtual ICollection<PartWorkOrder> PartWorkOrder { get; set; } = new List<PartWorkOrder>();
    }
}
