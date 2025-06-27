import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/login/login_request.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/api/models/news_response.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/utils/utils.dart';
import 'package:mtc/widgets/login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final apiService = Get.find<ApiService>();

  User? userData;
  var showLoadingForLogin = false.obs;
  var allNews = <NewsResponse>[].obs;
  var showLoading = true.obs;

  void init() async {
    await checkUserIsLogin();
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

  Future checkUserIsLogin() async {
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

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constant.userData);
  }

  void callLogoutApi() async {
    final response = await apiService.post(ApiEndpoint.logout, {});
    if (response != null && response.statusCode == 200) {
      apiService.clearToken();
      clearUser();
    }
  }
}
