using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Database.Models
{
    public class ReportWorkOrder
    {
        public decimal Total { get; set; }
        public List<WorkOrderInfo> WorkOrderInfo { get; set; } = new List<WorkOrderInfo> { };
    }

    public class WorkOrderInfo
    {
        public DateTime WorkOrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public List<ListOfWorkOrder> WorkOrders { get; set; } = new List<ListOfWorkOrder> { };
    }

    public class ListOfWorkOrder
    {
        public string OrderNumber { get; set; } = string.Empty;
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public decimal TotalSum { get; set; }
        public Service ServicePerformed { get; set; }
        public int UserId { get; set; }
        public string? UserName { get; set; }
        public string? UserSurname { get; set; }
        public int EmployeeId { get; set; }
        public string? EmployeeName { get; set; }
        public string Description { get; set; } = string.Empty;

    }
}
