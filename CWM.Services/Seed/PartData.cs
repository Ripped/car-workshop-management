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
                },
                new Part
                {
                    Id = 8,
                    SerialNumber = "RH245GFSU26GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Lezaj tocka",
                    Price = 39,
                    Image = null,
                    Description = "Lezaj tocka"
                },
                new Part
                {
                    Id = 9,
                    SerialNumber = "RT295TFSW76ZFS",
                    Manufacturer = "BOSCH",
                    PartName = "Filter klime",
                    Price = 39,
                    Image = null,
                    Description = "Filter klime"
                },
                new Part
                {
                    Id = 10,
                    SerialNumber = "RW238TFSW76GFS",
                    Manufacturer = "BOSCH",
                    PartName = "Senzor pritiska",
                    Price = 39,
                    Image = null,
                    Description = "Senzor pritiska"
                },
                new Part
                {
                    Id = 11,
                    SerialNumber = "RT135TFSW74GFS",
                    Manufacturer = "Ferodo",
                    PartName = "Disk plocice",
                    Price = 39,
                    Image = null,
                    Description = "Disk plocice"
                },
                new Part
                {
                    Id = 12,
                    SerialNumber = "RT235HFSW76GES",
                    Manufacturer = "Trusting",
                    PartName = "Disk plocice",
                    Price = 39,
                    Image = null,
                    Description = "Disk plocice"
                },
                new Part
                {
                    Id = 13,
                    SerialNumber = "RT255TFRW76GFS",
                    Manufacturer = "SWD",
                    PartName = "Diskovi zadnji",
                    Price = 39,
                    Image = null,
                    Description = "Diskovi zadnji"
                }
            );
        }
    }
}
