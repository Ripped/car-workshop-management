namespace CWM.Models
{
    public class PartInsertUpdate
    {
        public string SerialNumber { get; set; } = string.Empty;
        public string Manufacturer { get; set; } = string.Empty;
        public string PartName { get; set; } = string.Empty;
        public byte[]? Image { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; } = string.Empty;
    }
}
