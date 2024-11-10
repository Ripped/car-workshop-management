using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class CityData
    {
        public static void SeedData(this EntityTypeBuilder<City> entity)
        {
            entity.HasData(
                new City
                {
                    Id = 1,
                    Name = "Mostar",
                    CountryId = 6
                },
                new City
                {
                    Id = 2,
                    Name = "Jablanica",
                    ZipCode = "88420",
                    CountryId = 1
                },
                new City
                {
                    Id = 3,
                    Name = "Gračanica",
                    ZipCode = "88400",
                    CountryId = 1
                },
                new City
                {
                    Id = 4,
                    Name = "Tuzla",
                    CountryId = 5
                },
                new City
                {
                    Id = 5,
                    Name = "Srebrenik",
                    ZipCode = "88000",
                    CountryId = 1
                },
                new City
                {
                    Id = 6,
                    Name = "Živinice",
                    CountryId = 2
                }
            );
        }
    }
}
