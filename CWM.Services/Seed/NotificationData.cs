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
    public static class NotificationData
    {
        public static void SeedData(this EntityTypeBuilder<Notification> entity)
        {
            entity.HasData(
                new Notification
                {
                    Id = 1,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId=1,
                },
                new Notification
                {
                    Id = 2,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId = 1,
                },
                new Notification
                {
                    Id = 3,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId = 1,
                },
                new Notification
                {
                    Id = 4,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId = 1,
                },
                new Notification
                {
                    Id = 5,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId = 1,
                },
                new Notification
                {
                    Id = 6,
                    Description = "Akcija na servise za vozila starija od 5 god!",
                    Name = "Servis akcija",
                    UserId = 1,
                }
            );
        }
    }
}
