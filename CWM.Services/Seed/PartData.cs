using CWM.Database.Models;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Seed
{
    public static class PartData
    {
        public static void SeedData(this EntityTypeBuilder<Part> entity)
        {
            entity.HasData(
                new Part
                {
                    Id = 1,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                },
                new Part
                {
                    Id = 2,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                },
                new Part
                {
                    Id = 3,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                },
                new Part
                {
                    Id = 4,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                },
                new Part
                {
                    Id = 5,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                },
                new Part
                {
                    Id = 6,
                    SerialNumber = "RT245GFSW26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Kompresor klime",
                    Price = 39,
                    Image = null,
                    Description = "Kompresor klime"
                }
            );
        }
    }
}
