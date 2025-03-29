using CWM.Core.Models.Configurations;
using Microsoft.Extensions.Options;
using Stripe;
using Microsoft.IdentityModel.Tokens;
using CWM.Core.Interfaces.Services;
using CWM.Core.Models;

namespace CWM.Database.Repositories
{
    public class PaymentRepository : IPaymentService
    {
        private readonly StripeSettings _stripeSettings;

        public PaymentRepository(IOptions<StripeSettings> stripeSettings)
        {
            _stripeSettings = stripeSettings.Value;
            StripeConfiguration.ApiKey = _stripeSettings.SecretKey;
        }

        public async Task CreateRefundAsync(string paymentIntentId)
        {
            var refundService = new RefundService();

            var options = new RefundCreateOptions
            {
                PaymentIntent = paymentIntentId
            };

            await refundService.CreateAsync(options);
        }

        public async Task<PaymentResponse> ConfirmPayment(PaymentInsertUpdate request)
        {
            var intentOptions = new PaymentIntentCreateOptions
            {
                Amount = request.TotalAmount,
                Currency = "eur",
                PaymentMethodTypes = new List<string> { "card" },
                Metadata = new Dictionary<string, string>
                {
                    { "order_id", request.WorkOrderId.ToString() },
                    { "username", request.Username },
                },
            };

            var service = new PaymentIntentService();

            var intent = await service.CreateAsync(intentOptions);

            var confirmOptions = new PaymentIntentConfirmOptions
            {
                PaymentMethod = request.PaymentMethodId,
            };

            var response = new PaymentResponse { PaymentIntentId = intent.Id };

            try
            {
                var confirmation = await service.ConfirmAsync(intent.Id, confirmOptions);

                response.Message = confirmation.Status;
            }
            catch (StripeException ex)
            {
                response.Message = ex.StripeError?.Message ?? "An error occurred while processing the payment.";
            }

            return response;
        }

        public async Task<IntentResponse> CreatePaymentIntent(PaymentInsertUpdate request)
        {
            var metadata = new Dictionary<string, string>();

            if (!request.Username.IsNullOrEmpty())
            {
                metadata.Add("user", request.Username!);
            }
            if (request.WorkOrderId.HasValue)
            {
                metadata.Add("order_id", request.WorkOrderId.Value.ToString());
            }


            var options = new PaymentIntentCreateOptions
            {
                Amount = request.TotalAmount,
                Currency = "eur",
                PaymentMethodTypes = new List<string> { "card" },
                CaptureMethod = "automatic",
                Metadata = metadata
            };

            var service = new PaymentIntentService();
            var paymentintent = await service.CreateAsync(options);

            var response = new IntentResponse
            {
                PaymentIntentId = paymentintent.Id,
                clientSecret = paymentintent.ClientSecret
            };

            return response;
        }
    }
}
