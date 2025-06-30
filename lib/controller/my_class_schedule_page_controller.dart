import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/lesson_response.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/utils/utils.dart';
import 'package:mtc/widgets/class_schedule_detail_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClassSchedulePageController extends GetxController {
  final apiService = Get.find<ApiService>();

  var allLessons = <LessonsResponse>[].obs;
  var filteredLessons = <LessonsResponse>[].obs;
  var lessonLoading = true.obs;
  User? userData;
  var showLoadingForLogin = false.obs;

  void init() async {
    super.onInit();
    userData = await getUser();
    getAllLessons();
  }

  void getAllLessons() async {
    lessonLoading.value = true;
    Map<String, dynamic> data = {};
    data['user_id'] = userData?.id ?? 0;
    final response = await apiService.get(ApiEndpoint.getAllLessons, query: data);
    if (response != null && response.statusCode == 200) {
      lessonLoading.value = false;
      final List<LessonsResponse> lessonsList = List<LessonsResponse>.from((response.data['data'] as List).map((x) => LessonsResponse.fromJson(x)));
      allLessons.clear();
      allLessons.addAll(lessonsList);
      filteredLessons.assignAll(allLessons);
      print(allLessons);
    } else {
      Utils.showSnackBar(AppString.someThingWentWrong);
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

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(Constant.userData);
    if (userString != null) {
      return User.fromJson(jsonDecode(userString));
    }
    return null;
  }
}
