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
                    Description = "Pregled vozila, zamjena guma",
                    Sugestions = "Provjera klime",
                    VehicleId = 1,
                    EmployeeId = 1,
                    UserId = 1,
                },
                new VehicleServiceHistory
                {
                    Id = 2,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "Pregled vozila, zamjena guma",
                    Sugestions = "Provjera klime",
                    VehicleId = 2,
                    EmployeeId = 2,
                    UserId = 2,
                },
                new VehicleServiceHistory
                {
                    Id = 3,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Inspection,
                    Description = "Pregled vozila, zamjena guma",
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
                    Description = "Pregled vozila, zamjena guma",
                    Sugestions = "Provjera klime",
                    VehicleId = 9,
                    EmployeeId = 2,
                    UserId = 3,
                },
                new VehicleServiceHistory
                {
                    Id = 5,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Mechanical,
                    Description = "Pregled vozila, zamjena guma",
                    Sugestions = "Provjera klime",
                    VehicleId = 7,
                    EmployeeId = 3,
                    UserId = 3,
                },
                new VehicleServiceHistory
                {
                    Id = 6,
                    ServiceDate = DateTime.Now,
                    ServiceType = Service.Electrical,
                    Description = "Pregled vozila, zamjena guma",
                    Sugestions = "Provjera klime",
                    VehicleId = 8,
                    EmployeeId = 1,
                    UserId = 3,
                }
            );
        }
    }
    
}
