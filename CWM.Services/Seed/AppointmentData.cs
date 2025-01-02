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
    public static class AppointmentData
    {
        public static void SeedData(this EntityTypeBuilder<Appointment> entity)
        {
            entity.HasData(
                new Appointment
                {
                    Id = 1,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 1,
                    UserId = 1,
                    VehicleId = 1,
                },
                new Appointment
                {
                    Id = 2,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 2,
                    UserId = 2,
                    VehicleId = 2,
                },
                new Appointment
                {
                    Id = 3,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 3,
                    UserId = 3,
                    VehicleId = 3,
                },
                new Appointment
                {
                    Id = 4,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 1,
                    UserId = 4,
                    VehicleId = 4,
                },
                new Appointment
                {
                    Id = 5,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 2,
                    UserId = 5,
                    VehicleId = 5,
                },
                new Appointment
                {
                    Id = 6,
                    Description = "Pregled auta, mali servis i cudna buka na velikim brzinama",
                    StartDate = new DateTime(2024, 11, 27),
                    EndDate = new DateTime(2024, 11, 27),
                    AppointmentTypeId = 3,
                    UserId = 6,
                    VehicleId = 1,
                }
            );
        }
    }
}
