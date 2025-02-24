// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:news_app/models/news_api_model.dart';
import 'package:news_app/secrets.dart';
import 'package:news_app/view_model/services/api_services.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var data = [].obs;

  void onInit() {
    super.onInit();
    fetchData();
  }

  fetchData() async {
    String keywordTitle = "";
    try {
      isLoading(true);
      var data = await ApiServices.getApi(
          url:
              "https://newsapi.org/v2/everything?q=${keywordTitle}&apiKey=$apiKey");
      var data1 = await ApiServices.getApi(
          url:
              "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey");

      if (data != null && data1 != null) {
        isLoading(false);
        return AllData(newsHeadingData: data1, newsEverythingData: data);
        // emit(BlocLoadedState(newsEverythingData: data, newsHeadingData: data1));
      } else {
        isLoading(false);
        return "Data No Loaded properly";
        // emit(BlocErrorState(errorMsg: "No Data loaded...."));
      }
      // data1.assignAll(photoList);
    } catch (e) {
      print("Error fetching photos:");
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
