import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/lesson_response.dart';
import 'package:mtc/resource/params.dart';
import 'package:mtc/routes/app_routes.dart';
import 'package:mtc/widgets/class_schedule_detail_bottom_sheet.dart';

class ClassSchedulePageController extends GetxController {
  final api = Get.find<ApiService>();

  var allLessons = <LessonsResponse>[].obs;
  var filteredLessons = <LessonsResponse>[].obs;
  var lessonLoading = true.obs;

  void init() {
    super.onInit();
    getAllLessons();
  }

  void getAllLessons() async {
    lessonLoading.value = true;
    final response = await api.get(ApiEndpoint.getAllLessons);
    if (response != null && response.statusCode == 200) {
      lessonLoading.value = false;
      final List<LessonsResponse> lessonsList = List<LessonsResponse>.from((response.data['data'] as List).map((x) => LessonsResponse.fromJson(x)));
      allLessons.clear();
      allLessons.addAll(lessonsList);
      filteredLessons.assignAll(allLessons);
      print(allLessons);
    }
  }

  void filterLessons(String query) {
    if (query.isEmpty) {
      filteredLessons.assignAll(allLessons);
    } else {
      filteredLessons.assignAll(
        allLessons.where(
          (lesson) =>
              (lesson.title?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (lesson.code?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
              (lesson.courseOfferingCode?.toLowerCase().contains(query.toLowerCase()) ?? false),
        ),
      );
    }
  }

  void openDetailLessonChartBottomSheet(LessonsResponse lesson) {
    Get.bottomSheet(
      Wrap(children: [ClassScheduleDetailBottomSheet(lessonsResponse: lesson)]),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }

  void openMyClassSchedulePage() {
    Get.toNamed(AppRoutes.MY_CLASS_SCHEDULE_PAGE);
  }
}
