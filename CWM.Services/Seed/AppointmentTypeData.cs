using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class AppointmentTypeData
    {
        public static void SeedData(this EntityTypeBuilder<AppointmentType> entity)
        {
            entity.HasData(
                new AppointmentType
                {
                    Id = 1,
                    Name = "PENDING",
                    Color = "#cc7e0a"
                },
                new AppointmentType
                {
                    Id = 2,
                    Name = "APPROVED",
                    Color = "##1bb809"
                },
                new AppointmentType
                {
                    Id = 3,
                    Name = "NOT APPROVED",
                    Color = "#fc0303"
                }
            );
        }
    }
}
