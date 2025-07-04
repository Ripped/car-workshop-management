using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class VehicleData
    {
        public static void SeedData(this EntityTypeBuilder<Vehicle> entity)
        {
            entity.HasData(
                new Vehicle
                {
                    Id = 1,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11,12),
                    Fuel = "Gasoline",
                    UserId = 1
                },
                new Vehicle
                {
                    Id = 2,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 1
                },
                new Vehicle
                {
                    Id = 3,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 3
                },
                new Vehicle
                {
                    Id = 4,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 3
                },
                new Vehicle
                {
                    Id = 5,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 1
                },
                new Vehicle
                {
                    Id = 6,
                    Chassis = "WVWZZZ6NZ1Y125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 1
                },
                new Vehicle
                {
                    Id = 7,
                    Chassis = "WVWZZZ6NZ1Y3125494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 3
                },
                new Vehicle
                {
                    Id = 8,
                    Chassis = "WVWZZZ6NZ1Y1525494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 3
                },
                new Vehicle
                {
                    Id = 9,
                    Chassis = "WVWZZZ6NZ1Y1255494",
                    Brand = "Volkswagen",
                    Model = "Polo",
                    CubicCapacity = 1392,
                    Kilowatts = 55,
                    Transmision = "Manual",
                    ProductionDate = new DateTime(2000, 11, 12),
                    Fuel = "Gasoline",
                    UserId = 3
                }
            );
        }
    }
}
