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
    public static class PartWorkOrderData
    {
        public static void SeedData(this EntityTypeBuilder<Models.PartWorkOrder> entity)
        {
            entity.HasData(
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 1,
                    PartId = 1,
                    WorkOrderId = 1
                },
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 2,
                    PartId = 2,
                    WorkOrderId = 2
                },
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 3,
                    PartId = 3,
                    WorkOrderId = 3
                },
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 4,
                    PartId = 4,
                    WorkOrderId = 4
                },
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 5,
                    PartId = 5,
                    WorkOrderId = 5
                },
                new Models.PartWorkOrder
                {
                    ServiceDate = DateTime.Now,
                    VehicleId = 6,
                    PartId = 6,
                    WorkOrderId = 6
                }
            );
        }
    }
}
