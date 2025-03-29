using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class PaymentResponse
    {
        public string PaymentIntentId { get; set; } = string.Empty;
        public string Message { get; set; } = string.Empty;
    }
}
