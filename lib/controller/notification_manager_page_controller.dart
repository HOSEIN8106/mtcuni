import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/news/news_request.dart';
import 'package:mtc/api/models/news/news_response.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/utils/utils.dart';
import 'package:mtc/widgets/notification_dialog.dart';

class NotificationManagerPageController extends GetxController {
  final apiService = Get.find<ApiService>();

  var allNews = <NewsResponse>[].obs;
  var showLoading = true.obs;
  var showNewsLoading = false.obs;

  void init() {
    callGetAllNewsApi();
  }

  void callGetAllNewsApi() async {
    showLoading.value = true;
    Map<String, dynamic> data = {};
    data['expire_at'] = Utils.formatDateTime(DateTime.now());
    final response = await apiService.get(ApiEndpoint.getAllNews, query: data);
    if (response != null && response.statusCode == 200) {
      final List<NewsResponse> newsList = List<NewsResponse>.from((response.data['data'] as List).map((x) => NewsResponse.fromJson(x)));
      allNews.clear();
      allNews.addAll(newsList);
    } else {
      Utils.showSnackBar(AppString.someThingWentWrong);
    }
    showLoading.value = false;
  }

  void callCreateNewsApi(NewsRequest newsRequest) async {
    showNewsLoading.value = true;
    final response = await apiService.post(ApiEndpoint.creteNewNews, newsRequest.toJson());
    if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
      Get.back();
      callGetAllNewsApi();
    } else {
      Utils.showSnackBar(AppString.someThingWentWrong);
    }
    showNewsLoading.value = false;
  }

  void openNotificationDialog() {
    Get.dialog(
      NotificationDialog(
        showLoading: showNewsLoading,
        onCreate: (newsRequest) {
          callCreateNewsApi(newsRequest);
        },
      ),
    );
  }
}
