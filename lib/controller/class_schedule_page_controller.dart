import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/lesson_response.dart';
import 'package:mtc/api/models/login/login_request.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/resource/params.dart';
import 'package:mtc/routes/app_routes.dart';
import 'package:mtc/utils/utils.dart';
import 'package:mtc/widgets/class_schedule_detail_bottom_sheet.dart';
import 'package:mtc/widgets/login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassSchedulePageController extends GetxController {
  final apiService = Get.find<ApiService>();

  var allLessons = <LessonsResponse>[].obs;
  var filteredLessons = <LessonsResponse>[].obs;
  var lessonLoading = true.obs;
  User? userData;
  var showLoadingForLogin = false.obs;

  void init() {
    super.onInit();
    getAllLessons();
  }

  void getAllLessons() async {
    lessonLoading.value = true;
    final response = await apiService.get(ApiEndpoint.getAllLessons);
    if (response != null && response.statusCode == 200) {
      lessonLoading.value = false;
      final List<LessonsResponse> lessonsList = List<LessonsResponse>.from((response.data['data'] as List).map((x) => LessonsResponse.fromJson(x)));
      allLessons.clear();
      allLessons.addAll(lessonsList);
      filteredLessons.assignAll(allLessons);
      print(allLessons);
    }else{
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

  void openMyClassSchedulePage() {
    Get.toNamed(AppRoutes.MY_CLASS_SCHEDULE_PAGE);
  }

  void checkUserIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constant.accessToken)?.isNotEmpty ?? false) {
      userData = await getUser();
    }
  }

  void openLoginDialog() {
    Get.dialog(
      LoginDialog(
        onLoginClick: (username, password) {
          callLoginApi(username, password);
        },
        showLoading: showLoadingForLogin,
      ),
    );
  }

  void callLoginApi(String username, String password) async {
    showLoadingForLogin.value = true;
    LoginRequest loginRequest = LoginRequest(username: username, password: password);
    final response = await apiService.post(ApiEndpoint.login, loginRequest.toJson());
    if (response != null && response.statusCode == 200) {
      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      apiService.saveToken(loginResponse.token ?? '');
      saveUser(loginResponse.user?.toJson() ?? {});
      Get.back();
      checkUserIsLogin();
    } else {
      Utils.showSnackBar(AppString.wrongInputData);
    }
    showLoadingForLogin.value = false;
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.userData, jsonEncode(user));
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
