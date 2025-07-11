﻿using CWM.Core.Models.Enums;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CWM.Models
{
    public class VehicleServiceHistoryInsertUpdate
    {
        public DateTime? ServiceDate { get; set; }
        public Service ServiceType { get; set; }
        public string Description { get; set; } = string.Empty;
        public string Sugestions { get; set; } = string.Empty;

        [Required]
        public int? VehicleId { get; set; }
        [Required]
        public int? EmployeeId { get; set; }
        [Required]
        public int? UserId { get; set; }

    }
}
