using CWM.Core.Models.Enums;
using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class VehicleServiceHistoryData
    {
        public static void SeedData(this EntityTypeBuilder<VehicleServiceHistory> entity)
        {
            entity.HasData(
                new VehicleServiceHistory
                {
                    Id = 1,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Mechanical,
                    Description = "",
                    VehicleId = 1
                },
                new VehicleServiceHistory
                {
                    Id = 2,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "",
                    VehicleId = 2
                },
                new VehicleServiceHistory
                {
                    Id = 3,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Inspection,
                    Description = "",
                    VehicleId = 3
                },
                new VehicleServiceHistory
                {
                    Id = 4,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Other,
                    Description = "",
                    VehicleId = 4
                },
                new VehicleServiceHistory
                {
                    Id = 5,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Mechanical,
                    Description = "",
                    VehicleId = 5
                },
                new VehicleServiceHistory
                {
                    Id = 6,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "",
                    VehicleId = 6
                }
            );
        }
    }
    
}
