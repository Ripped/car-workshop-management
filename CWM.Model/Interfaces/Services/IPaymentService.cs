using CWM.Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CWM.Core.Interfaces.Services
{
    public interface IPaymentService
    {
        Task<PaymentResponse> ConfirmPayment(PaymentInsertUpdate request);
        Task<IntentResponse> CreatePaymentIntent(PaymentInsertUpdate request);
        Task CreateRefundAsync(string paymentIntentId);
    }
}
