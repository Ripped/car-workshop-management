import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import '../models/searches/work_order_search.dart';
import '../models/work_order.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class WorkOrderProvider extends BaseProvider<WorkOrder, WorkOrderSearch> {
  @override
  WorkOrder fromJson(data) => WorkOrder.fromJson(data);

  Future<void> insertReservation(WorkOrder workOrder, double amount) async {
    final reservationResponseBody = workOrder;

    int totalAmount = (amount * 100).toInt();

    final paymentIntentResponse =
        await _createPaymentIntent(workOrder.id, totalAmount);

    final paymentIntentResponseBody = jsonDecode(paymentIntentResponse.body);

    final clientSecret = paymentIntentResponseBody['clientSecret'];
    final paymentIntentId = paymentIntentResponseBody['paymentIntentId'];

    try {
      await _confirmPayment(clientSecret);

      print('Payment successful');
    } catch (e) {
      print('Payment failed: $e');
    }
  }

  Future<dynamic> _createPaymentIntent(int workOrderId, int totalAmount) async {
    var uri = Uri.parse('https://$baseUrl/Payment/CreatePaymentIntent');

    final response = await http.post(uri,
        headers: createHeaders(),
        body: jsonEncode(
            {'workOrderId': workOrderId, 'totalAmount': totalAmount}));

    return response;
  }

  Future<void> _confirmPayment(String clientSecret) async {
    await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData()),
      options: const PaymentMethodOptions(
        setupFutureUsage: PaymentIntentsFutureUsage.OffSession,
      ),
    );
  }
}
