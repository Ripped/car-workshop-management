import 'dart:convert';

import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import 'package:http/http.dart' as http;

import '../models/part.dart';
import '../models/searches/part_search.dart';

class RecommenderProvider extends BaseProvider<Part, PartSearch> {
  @override
  Part fromJson(data) => Part.fromJson(data);

  Future<List<dynamic>> getRecommendParts(int id) async {
    String endpointRecommender = "RecommendParts";
    var uri = Uri.https(baseUrl, '$endpointRecommender/$id');

    var response = await http.get(uri, headers: createHeaders());

    List<dynamic> parts;

    if (isValidResponse(response)) {
      parts = json
          .decode(response.body.toString())
          .map((data) => Part.fromJson(data))
          .toList();

      return parts;
    } else {
      throw Exception("Response is not valid");
    }
  }
}
