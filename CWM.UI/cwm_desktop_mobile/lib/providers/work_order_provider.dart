import 'dart:convert';
import 'package:cwm_desktop_mobile/models/report_work_order.dart';
import 'package:cwm_desktop_mobile/models/searches/report_work_order_search.dart';
import 'package:http/http.dart' as http;
import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import '../models/searches/work_order_search.dart';
import '../models/work_order.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class WorkOrderProvider extends BaseProvider<WorkOrder, WorkOrderSearch> {
  @override
  WorkOrder fromJson(data) => WorkOrder.fromJson(data);

  Future<ReportWorkOrder> getServiceReport(ReportWorkOrderSearch search) async {
    final Map<String, String> queryParameters = {};
    String endpointIzvjestajNarudzbe = "GetServiceReport";

    var url = "http://$baseUrl/WorkOrder/$endpointIzvjestajNarudzbe";

    search.toJson().forEach((key, value) {
      queryParameters.addAll(<String, String>{key: value});
    });

    queryParameters.removeWhere((key, value) => value == "null");

    var uri = Uri.https(
        baseUrl, 'WorkOrder/$endpointIzvjestajNarudzbe', queryParameters);

    var response = await http.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data == null || data is! Map<String, dynamic>) {
        print("Neispravan format odgovora!");
        throw Exception('Neispravan format odgovora!');
      }

      //ReportWorkOrder izvjestajNarudzbe = ReportWorkOrder.fromJson(data);

      return ReportWorkOrder.fromJson(data);
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

  Future<ReportWorkOrder> getOrderReport(ReportWorkOrderSearch search) async {
    final Map<String, String> queryParameters = {};
    String endpointIzvjestajNarudzbe = "GetOrderReport";

    var url = "https://$baseUrl/WorkOrder/$endpointIzvjestajNarudzbe";

    search.toJson().forEach((key, value) {
      queryParameters.addAll(<String, String>{key: value});
    });

    queryParameters.removeWhere((key, value) => value == "null");

    var uri = Uri.https(
        baseUrl, 'WorkOrder/$endpointIzvjestajNarudzbe', queryParameters);

    var response = await http.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data == null || data is! Map<String, dynamic>) {
        print("Neispravan format odgovora!");
        throw Exception('Neispravan format odgovora!');
      }

      //ReportWorkOrder izvjestajNarudzbe = ReportWorkOrder.fromJson(data);

      return ReportWorkOrder.fromJson(data);
    } else {
      throw Exception("Nepoznata greška!");
    }
  }

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
