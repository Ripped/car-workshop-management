using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class PaymentInsertUpdate
    {
        public int? WorkOrderId { get; set; }
        public long TotalAmount { get; set; }
        public string? PaymentMethodId { get; set; }
        public string? Username { get; set; }
    }
}
