import 'dart:convert';
import 'dart:io';

import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import '../models/paged_result.dart';
import '../models/searches/base_search.dart';

abstract class BaseProvider<T, TSearch extends BaseSearch> with ChangeNotifier {
  late String baseUrl;
  late String endpoint;

  BaseProvider({String? altEndpoint}) {
    /*baseUrl = const String.fromEnvironment(
      "ApiUrl",
      defaultValue: "localhost:50443",
    );*/

    if (Platform.isWindows || Platform.isMacOS) {
      baseUrl = const String.fromEnvironment(
        "ApiUrl",
        defaultValue: "localhost:50443",
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      baseUrl = const String.fromEnvironment(
        "ApiUrl",
        defaultValue: "10.0.2.2:50443",
      );
    }

    endpoint = altEndpoint ?? T.toString();
  }

  Future<T> get(int id) async {
    var uri = Uri.https(baseUrl, '$endpoint/$id');

    var response = await http.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Response is not valid");
    }
  }

  Future<PagedResult<T>> getAll({TSearch? search}) async {
    final Map<String, String> queryParameters = {};

    if (search != null) {
      search.toJson().forEach((key, value) {
        queryParameters.addAll(<String, String>{key: value.toString()});
      });

      queryParameters.removeWhere((key, value) => value == "null");
    }

    var uri = Uri.https(baseUrl, endpoint, queryParameters);

    var response = await http.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = PagedResult<T>();

      result.totalCount = data['totalCount'];
      result.totalPages = data['totalPages'];
      result.page = data['page'];
      result.pageSize = data['pageSize'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Response is not valid");
    }
  }

  Future<T> insert(dynamic request) async {
    var uri = Uri.https(baseUrl, endpoint);

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);

    var response =
        await http.post(uri, headers: createHeaders(), body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Response is not valid");
    }
  }

  Future<T> update(int id, dynamic request) async {
    var uri = Uri.https(baseUrl, '$endpoint/$id');

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);

    var response =
        await http.put(uri, headers: createHeaders(), body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Response is not valid");
    }
  }

  Future<bool> delete(int id) async {
    var uri = Uri.https(baseUrl, '$endpoint/$id');

    var response = await http.delete(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      return true;
    } else {
      throw Exception("Response is not valid");
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

  bool isValidResponse(http.Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Something bad happened");
    }
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }

  T fromJson(data) => throw Exception("Method not implemented");
}
