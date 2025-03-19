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
        public static void SeedData(this EntityTypeBuilder<PartWorkOrder> entity)
        {
            entity.HasData(
                new PartWorkOrder
                {
                    Id = 1,
                    ServiceDate = DateTime.Now,
                    VehicleId = 1,
                    PartId = 1,
                    WorkOrderId = 1
                },
                new PartWorkOrder
                {
                    Id = 2,
                    ServiceDate = DateTime.Now,
                    VehicleId = 2,
                    PartId = 2,
                    WorkOrderId = 2
                },
                new PartWorkOrder
                {
                    Id = 3,
                    ServiceDate = DateTime.Now,
                    VehicleId = 3,
                    PartId = 3,
                    WorkOrderId = 3
                },
                new PartWorkOrder
                {
                    Id = 4,
                    ServiceDate = DateTime.Now,
                    VehicleId = 4,
                    PartId = 4,
                    WorkOrderId = 4
                },
                new PartWorkOrder
                {
                    Id = 5,
                    ServiceDate = DateTime.Now,
                    VehicleId = 5,
                    PartId = 5,
                    WorkOrderId = 5
                },
                new PartWorkOrder
                {
                    Id = 6,
                    ServiceDate = DateTime.Now,
                    VehicleId = 6,
                    PartId = 6,
                    WorkOrderId = 6
                }
            );
        }
    }
}
