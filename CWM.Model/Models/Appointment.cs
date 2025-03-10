using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class Appointment : Base
    {
        public string Description { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public User? User { get; set; } = new();
        public AppointmentType? AppointmentType { get; set; } = new();
        public Vehicle? Vehicle { get; set; } = new();


        public string ToJson()
        => JsonSerializer.Serialize(this, new JsonSerializerOptions() { PropertyNamingPolicy = JsonNamingPolicy.CamelCase });
    }
}
