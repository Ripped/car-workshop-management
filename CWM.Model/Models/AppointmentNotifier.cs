using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class AppointmentNotifier
    {
        public int Id { get; set; }

        public string Description { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public String? Vehicle { get; set; } = string.Empty;
        public String? User { get; set; } = string.Empty;

        public string ToJson()
        => JsonSerializer.Serialize(this, new JsonSerializerOptions() { PropertyNamingPolicy = JsonNamingPolicy.CamelCase });
    }
}
