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
                    Sugestions = "",
                    VehicleId = 1,
                    EmployeeId = 1,
                    UserId = 1,
                },
                new VehicleServiceHistory
                {
                    Id = 2,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "",
                    Sugestions = "",
                    VehicleId = 2,
                    EmployeeId = 2,
                    UserId = 2,
                },
                new VehicleServiceHistory
                {
                    Id = 3,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Inspection,
                    Description = "",
                    Sugestions = "",
                    VehicleId = 3,
                    EmployeeId = 3,
                    UserId = 3,
                },
                new VehicleServiceHistory
                {
                    Id = 4,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Other,
                    Description = "",
                    Sugestions = "",
                    VehicleId = 4,
                    EmployeeId = 4,
                    UserId = 4,
                },
                new VehicleServiceHistory
                {
                    Id = 5,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Mechanical,
                    Description = "",
                    Sugestions = "",
                    VehicleId = 5,
                    EmployeeId = 5,
                    UserId = 5,
                },
                new VehicleServiceHistory
                {
                    Id = 6,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "",
                    Sugestions = "",
                    VehicleId = 6,
                    EmployeeId = 6,
                    UserId = 6,
                }
            );
        }
    }
    
}
