using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class AppointmentBlockedData
    {
        public static void SeedData(this EntityTypeBuilder<AppointmentBlocked> entity)
        {
            entity.HasData(
                new AppointmentBlocked
                {
                    Id = 1,
                    BlockedDate = new DateTime(2024, 11, 21),
                },
                new AppointmentBlocked
                {
                    Id = 2,
                    BlockedDate = new DateTime(2024, 11, 22),
                },
                new AppointmentBlocked
                {
                    Id = 3,
                    BlockedDate = new DateTime(2024, 11, 23),
                },
                new AppointmentBlocked
                {
                    Id = 4,
                    BlockedDate = new DateTime(2024, 11, 24),
                },
                new AppointmentBlocked
                {
                    Id = 5,
                    BlockedDate = new DateTime(2024, 11, 25),
                },
                new AppointmentBlocked
                {
                    Id = 6,
                    BlockedDate = new DateTime(2024, 11, 26),
                }
            );
        }
    }
}
