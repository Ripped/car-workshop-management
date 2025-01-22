using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class VehicleServiceHistorySearch : BaseSearch
    {
        public string? Name { get; set; }
        public int? VehicleId { get; set; }
        public DateTime? ServiceDate { get; set; }
        public bool IncludeVehicle {  get; set; }
    }
}
