using CWM.Core.Interfaces.Services;
using CWM.Core.Models;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace CWM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PaymentController : ControllerBase
    {
        private readonly IPaymentService _paymentService;

        public PaymentController(IPaymentService paymentService)
        {
            _paymentService = paymentService;
        }

        [HttpPost("ConfirmPayment")]
        public async Task<IActionResult> ConfirmPayment([FromBody] PaymentInsertUpdate request)
        {
            var confirmation = await _paymentService.ConfirmPayment(request);
            return Ok(confirmation);
        }

        [HttpPost("CreatePaymentIntent")]
        public async Task<IntentResponse> CreatePaymentIntent(PaymentInsertUpdate request)
        {
            var intent = await _paymentService.CreatePaymentIntent(request);
            return await _paymentService.CreatePaymentIntent(request);
        }
    }
}

