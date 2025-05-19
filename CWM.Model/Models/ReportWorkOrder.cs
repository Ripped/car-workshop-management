using CWM.Core.Models.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class ReportWorkOrder
    {
        public decimal Total { get; set; }
        public double TotalHours { get; set; }
        public List<WorkOrderInfo> WorkOrderInfo { get; set; } = new List<WorkOrderInfo> { };
    }

    public class WorkOrderInfo
    {
        public DateTime WorkOrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public List<ListOfWorkOrder> WorkOrders { get; set; } = new List<ListOfWorkOrder> { };
        public List<ListOfServiceReport> ServiceReports { get; set; } = new List<ListOfServiceReport> { };
    }

    public class ListOfWorkOrder
    {
        public string OrderNumber { get; set; } = string.Empty;
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public int TotalTime { get; set; }
        public decimal TotalSum { get; set; }
        public Service ServicePerformed { get; set; }
        public User? User { get; set; }
        public Employee? Employee { get; set; }
        public string Description { get; set; } = string.Empty;
    }
    public class ListOfServiceReport
    {
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public double Time { get; set; }
        public double TotalTime { get; set; }
        public Service ServicePerformed { get; set; }
        public Employee? Employee { get; set; }
    }

    public class ServiceTime {
        public double Time { get; set; }
        public Service ServicePerformed { get; set; }
    }
}
