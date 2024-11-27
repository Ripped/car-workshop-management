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
    public static class UserRoleData
    {
        public static void SeedData(this EntityTypeBuilder<UserRole> entity)
        {
            entity.HasData(
                new UserRole
                {
                    Id = 1,
                    UserId = 1,
                    Role = Role.Admin
                },
                new UserRole
                {
                    Id = 2,
                    UserId = 1,
                    Role = Role.Employee
                },
                new UserRole
                {
                    Id = 3,
                    UserId = 1,
                    Role = Role.User
                },
                new UserRole
                {
                    Id = 4,
                    UserId = 1,
                    Role = Role.Employee
                },
                new UserRole
                {
                    Id = 5,
                    UserId = 1,
                    Role = Role.Employee
                },
                new UserRole
                {
                    Id = 6,
                    UserId = 1,
                    Role = Role.User
                }
            );
        }
    }
}
