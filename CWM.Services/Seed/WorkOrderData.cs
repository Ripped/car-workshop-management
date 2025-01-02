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
    public static class WorkOrderData
    {
        public static void SeedData(this EntityTypeBuilder<WorkOrder> entity)
        {
            entity.HasData(
                new WorkOrder
                {
                    Id = 1,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Mechanical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 1,
                    VehicleId = 1,
                    UserId = 1
                },
                new WorkOrder
                {
                    Id = 2,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Electrical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 2,
                    VehicleId = 2,
                    UserId = 2
                },
                new WorkOrder
                {
                    Id = 3,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Inspection,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 3,
                    VehicleId = 3,
                    UserId = 3
                },
                new WorkOrder
                {
                    Id = 4,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Suspension,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 4,
                    VehicleId = 4,
                    UserId = 4
                },
                new WorkOrder
                {
                    Id = 5,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Other,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 5,
                    VehicleId = 5,
                    UserId = 5
                },
                new WorkOrder
                {
                    Id = 6,
                    OrderNumber = "SGTA252ASF276",
                    StartTime = DateTime.Now,
                    EndTime = DateTime.Now,
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Mechanical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6
                }
            );
        }
    }
}
