// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:news_app/models/news_api_model.dart';
import 'package:news_app/secrets.dart';
import 'package:news_app/view_model/services/api_services.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsEverythingData = Rxn<NewsDataModel>(); // Rxn for nullable object
  var newsHeadingData = Rxn<NewsDataModel>();

  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData({String query = "all"}) async {
    try {
      isLoading(true);

      var everythingResponse = await ApiServices.getApi(
          url: "https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey");

      var headlinesResponse = await ApiServices.getApi(
          url:
              "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey");

      if (everythingResponse != null && headlinesResponse != null) {
        newsEverythingData.value =
            NewsDataModel.fromJson(everythingResponse as Map<String, dynamic>);
        newsHeadingData.value =
            NewsDataModel.fromJson(headlinesResponse as Map<String, dynamic>);
      } else {
        print("Data not loaded properly");
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }
}

class AllData {
  NewsDataModel newsHeadingData;
  NewsDataModel newsEverythingData;
  AllData({
    required this.newsHeadingData,
    required this.newsEverythingData,
  });
}
