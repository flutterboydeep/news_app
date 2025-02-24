import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/news_api_model.dart';

class ApiServices {
  static Future<NewsDataModel?> getApi({required String url}) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dataM = NewsDataModel.fromJson(data);
      return dataM;
    } else {
      return null;
    }
  }
}
