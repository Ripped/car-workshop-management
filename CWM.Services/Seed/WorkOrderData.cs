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
                    OrderNumber = "SGTA152ASF276",
                    Total = 30,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Mechanical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 1,
                    VehicleId = 1,
                    UserId = 1,
                    EmployeeId = 1,
                },
                new WorkOrder
                {
                    Id = 2,
                    OrderNumber = "SGTA252ASF276",
                    Total = 40,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Electrical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 2,
                    VehicleId = 2,
                    UserId = 2,
                    EmployeeId = 2,
                },
                new WorkOrder
                {
                    Id = 3,
                    OrderNumber = "SGTA352ASF276",
                    Total = 20,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Inspection,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 3,
                    VehicleId = 3,
                    UserId = 3,
                    EmployeeId = 3,
                },
                new WorkOrder
                {
                    Id = 4,
                    OrderNumber = "SGTA452ASF276",
                    Total = 40,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Suspension,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 4,
                    VehicleId = 4,
                    UserId = 4,
                    EmployeeId = 4,
                },
                new WorkOrder
                {
                    Id = 5,
                    OrderNumber = "SGTA552ASF276",
                    Total = 60,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Other,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 5,
                    VehicleId = 5,
                    UserId = 5,
                    EmployeeId = 5,
                },
                new WorkOrder
                {
                    Id = 6,
                    OrderNumber = "SGTA652ASF276",
                    Total = 40,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Mechanical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6,
                    EmployeeId = 6,
                },
                new WorkOrder
                {
                    Id = 7,
                    OrderNumber = "SGTA752ASF276",
                    Total = 50,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Electrical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6,
                    EmployeeId = 6,
                },
                new WorkOrder
                {
                    Id = 8,
                    OrderNumber = "SGTA852ASF276",
                    Total = 10,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Body,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6,
                    EmployeeId = 6,
                },
                new WorkOrder
                {
                    Id = 9,
                    OrderNumber = "SGTA952ASF276",
                    Total = 40,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Other,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6,
                    EmployeeId = 6,
                },
                new WorkOrder
                {
                    Id = 10,
                    OrderNumber = "SGTA102ASF276",
                    Total = 70,
                    StartTime = new DateTime(2024, 5, 4),
                    EndTime = new DateTime(2024, 5, 5),
                    GarageBox = GarageBox.Box1,
                    ServicePerformed = Service.Mechanical,
                    Concerne = "Paljenje auta",
                    Description = "Potrebno duze vrijeme da upali kada je auto zagrijano",
                    Sugestions = "Provjeriti dizne i alnaser",
                    AppointmentId = 6,
                    VehicleId = 6,
                    UserId = 6,
                    EmployeeId = 6,
                }
            );
        }
    }
}
