import 'dart:convert';
import 'dart:io';
import 'package:cwm_desktop_mobile/models/user_auth.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  late String? _baseUrl;
  final String _endpoint = "Login";

  AuthProvider() {
    if (Platform.isWindows || Platform.isMacOS) {
      _baseUrl = const String.fromEnvironment(
        "ApiUrl",
        defaultValue: "http://localhost:50080/",
      );
    }
    if (Platform.isAndroid || Platform.isIOS) {
      _baseUrl = const String.fromEnvironment(
        "ApiUrl",
        defaultValue: "http://10.0.2.2:50080/",
      );
    }
  }

  Future<dynamic> login() async {
    var url =
        "$_baseUrl$_endpoint?Username=${Authorization.username}&Password=${Authorization.password}";
    var uri = Uri.parse(url);

    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return UserAuth.fromJson(data);
    } else {
      return null;
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }
}
