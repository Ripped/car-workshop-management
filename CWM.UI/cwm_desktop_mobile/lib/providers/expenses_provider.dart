import 'dart:convert';

import 'package:cwm_desktop_mobile/models/expenses.dart';
import 'package:cwm_desktop_mobile/models/report_expenses_total.dart';
import 'package:cwm_desktop_mobile/models/searches/expenses_search.dart';
import 'package:cwm_desktop_mobile/models/searches/report_work_order_search.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class ExpensesProvider extends BaseProvider<Expenses, ExpensesSearch> {
  @override
  Expenses fromJson(data) => Expenses.fromJson(data);

  Future<ReportExpensesTotal> getFinanceReport(
      ReportWorkOrderSearch search) async {
    final Map<String, String> queryParameters = {};
    String endpointIzvjestajNarudzbe = "GetFinanceReport";

    if (search != null) {
      search.toJson().forEach((key, value) {
        queryParameters.addAll(<String, String>{key: value});
      });

      queryParameters.removeWhere((key, value) => value == "null");
    }

    var uri = Uri.https(
        baseUrl, 'Expenses/$endpointIzvjestajNarudzbe', queryParameters);

    var response = await http.get(uri, headers: createHeaders());

    //ReportExpenses list = (json.decode(response.body) as dynamic).cast<ReportExpenses>();

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      if (data == null || data is! Map<String, dynamic>) {
        print("Neispravan format odgovora!");
        throw Exception('Neispravan format odgovora!');
      }

      //ReportWorkOrder izvjestajNarudzbe = ReportWorkOrder.fromJson(data);

      return ReportExpensesTotal.fromJson(data);
    } else {
      throw Exception("Nepoznata greška!");
    }

    //list = json.decode(response.body);
    /*var uri = Uri.parse('https://$baseUrl/Expenses/GetFinanceReport');

    final response = await http.post(uri,
        headers: createHeaders(),
        body:
            jsonEncode({'datumOd': search.dateFrom, 'datumDo': search.dateTo}));*/

    //return list;
  }

  Future<Expenses> getFsinanceReport(ReportWorkOrderSearch search) async {
    final Map<String, String> queryParameters = {};
    String endpointIzvjestajNarudzbe = "GetFinanceReport";

    var url = "https://$baseUrl/WorkOrder/$endpointIzvjestajNarudzbe";

    if (search != null) {
      search.toJson().forEach((key, value) {
        queryParameters.addAll(<String, String>{key: value});
      });

      queryParameters.removeWhere((key, value) => value == "null");
    }

    var uri = Uri.https(
        baseUrl, 'Expenses/$endpointIzvjestajNarudzbe', queryParameters);

    var response = await http.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      /*if (data == null || data is! Map<String, dynamic>) {
        print("Neispravan format odgovora!");
        throw Exception('Neispravan format odgovora!');
      }*/

      return Expenses.fromJson(data);
    } else {
      throw Exception("Nepoznata greška!");
    }
  }
}
