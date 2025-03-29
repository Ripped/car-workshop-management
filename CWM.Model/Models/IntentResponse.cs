using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Models
{
    public class IntentResponse
    {
        public string PaymentIntentId { get; set; } = string.Empty;
        public string clientSecret { get; set; } = string.Empty;
    }
}
