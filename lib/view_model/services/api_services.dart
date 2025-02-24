import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/news_api_model.dart';

class ApiServices {
  static Future<Map<String, dynamic>> getApi({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body)
            as Map<String, dynamic>; // ✅ JSON Map return करें
      } else {
        print("Error: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      print("API fetch error: $e");
      return {};
    }
  }
}
