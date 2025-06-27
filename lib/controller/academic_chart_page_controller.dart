import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/chart_response.dart';
import 'package:mtc/utils/utils.dart';

class AcademicChartPageController extends GetxController {
  final apiService = Get.find<ApiService>();
  var isAssociate = true.obs;
  var chartData = <ChartResponse>[].obs;
  var isShowLoading = true.obs;

  void init() {
    callChartApi();
  }

  void handleTabClick(int index) {
    if (index == 0) {
      isAssociate.value = false;
    } else {
      isAssociate.value = true;
    }
    callChartApi();
  }

  void callChartApi() async {
    isShowLoading.value = true;
    Map<String, dynamic> data = {};
    data['degree_level'] = isAssociate.value ? 1 : 2;
    final response = await apiService.get(ApiEndpoint.charts, query: data);
    if (response != null && response.statusCode == 200) {
      final List<ChartResponse> chartList = List<ChartResponse>.from((response.data['data'] as List).map((x) => ChartResponse.fromJson(x)));
      chartData.clear();
      chartData.addAll(chartList);
    } else {
      Utils.showSnackBar("متاسفانه مشکلی پیش آمده است");
    }
    isShowLoading.value = false;
  }
}
