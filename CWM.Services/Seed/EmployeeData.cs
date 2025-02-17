using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class EmployeeData
    {
        public static void SeedData(this EntityTypeBuilder<Employee> entity)
        {
            entity.HasData(
                new Employee
                {
                    Id = 1,
                    FirstName = "Damir",
                    LastName = "Kahvic",
                    BirthDate = new DateTime(2001, 6, 5),
                    Username = "dario",
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "karić@gmail.com",
                    Mobile = "062342376",
                },
                new Employee
                {
                    Id = 2,
                    FirstName = "Selmir",
                    LastName = "Babić",
                    BirthDate = new DateTime(2001, 6, 5),
                    Username = "selmir",
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "babić@gmail.com",
                    Mobile = "062342376",
                },
                new Employee
                {
                    Id = 3,
                    FirstName = "Omer",
                    LastName = "Tufo",
                    BirthDate = new DateTime(2001, 6, 5),
                    Username = "omer",
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "tufo@gmail.com",
                    Mobile = "062342376",
                },
                new Employee
                {
                    Id = 4,
                    FirstName = "Emir",
                    LastName = "Oleg",
                    BirthDate = new DateTime(2001, 6, 5),
                    Username = "employee",
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "karić@gmail.com",
                    Mobile = "062342376",
                },
                new Employee
                {
                    Id = 5,
                    FirstName = "Faris",
                    LastName = "Mahic",
                    BirthDate = new DateTime(2001, 6, 5),
                    Username = "employee",
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "karić@gmail.com",
                    Mobile = "062342376",
                },
                new Employee
                {
                    Id = 6,
                    FirstName = "Aleksandar",
                    LastName = "Muftic",
                    BirthDate = new DateTime(2001, 6, 5),
                    CityId = 5,
                    CitizenshipId = 5,
                    Email = "karić@gmail.com",
                    Mobile = "062342376",
                }
            );
        }
    }
}
