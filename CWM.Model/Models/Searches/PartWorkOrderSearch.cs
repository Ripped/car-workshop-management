﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models.Searches
{
    public class PartWorkOrderSearch : BaseSearch
    {
        public string? PartName { get; set; }
        public bool IncludeWorkOrder { get; set; }
        public bool IncludePart { get; set; }
        public int? UserId { get; set; }
        public int? VehicleId { get; set; }
        public int? WorkOrderId { get; set; }
        public DateTime? ServiceDate { get; set; }

    }
}
