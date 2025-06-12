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
    public static class UserData
    {
        public static void SeedData(this EntityTypeBuilder<User> entity)
        {
            entity.HasData(
                new User
                {
                    Id = 1,
                    FirstName = "Amir",
                    LastName = "Sendić",
                    Gender = Gender.Male,
                    BirthDate = new DateTime(2001, 4, 5),
                    CityId = 1,
                    CitizenshipId = 1,
                    Image = null,
                    Email = "sendić@gmail.com",
                    Username = "Admin",
                    Password = "Admin",
                    Mobile = "062342376",
                },
                new User
                {
                    Id = 2,
                    FirstName = "Samra",
                    LastName = "Tufo",
                    Gender = Gender.Female,
                    BirthDate = new DateTime(2000, 6, 5),
                    CityId = 2,
                    CitizenshipId = 2,
                    Image = null,
                    Email = "stufo@gmail.com",
                    Username = "employee",
                    Password = "Admin",
                    Mobile = "062342376",
                },
                new User
                {
                    Id = 3,
                    FirstName = "Omer",
                    LastName = "Tufo",
                    Gender = Gender.Male,
                    BirthDate = new DateTime(1990, 6, 5),
                    CityId = 3,
                    CitizenshipId = 3,
                    Image = null,
                    Email = "tufo@gmail.com",
                    Username = "omer",
                    Password = "Admin",
                    Mobile = "062342376",
                },
                new User
                {
                    Id = 4,
                    FirstName = "Merima",
                    LastName = "Kremić",
                    Gender = Gender.Female,
                    BirthDate = new DateTime(1975, 6, 5),
                    CityId = 4,
                    CitizenshipId = 4,
                    Image = null,
                    Email = "kremić@gmail.com",
                    Username = "merima",
                    Password = "Admin",
                    Mobile = "062342376",
                },
                new User
                {
                    Id = 5,
                    FirstName = "Damir",
                    LastName = "Kahvic",
                    Gender = Gender.Male,
                    BirthDate = new DateTime(2001, 6, 5),
                    CityId = 5,
                    CitizenshipId = 5,
                    Image = null,
                    Email = "karić@gmail.com",
                    Username = "dario",
                    Password = "Admin",
                    Mobile = "062342376",
                },
                new User
                {
                    Id = 6,
                    FirstName = "Selmir",
                    LastName = "Babić",
                    Gender = Gender.Female,
                    BirthDate = new DateTime(1994, 6, 5),
                    CityId = 6,
                    CitizenshipId = 6,
                    Image = null,
                    Email = "babić@gmail.com",
                    Username = "selmir",
                    Password = "Admin",
                    Mobile = "062342376",
                }
            );
        }
    }
}
