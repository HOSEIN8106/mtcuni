import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/login/login_request.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/utils/utils.dart';
import 'package:mtc/widgets/login_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  final apiService = Get.find<ApiService>();

  User? userData;
  var showLoadingForLogin = false.obs;

  void init() {
    checkUserIsLogin();
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
      Utils.showSnackBar("اطلاعات وارد شده صحیح نمی باشد");
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

  void callLogoutApi()async{
    final response = await apiService.post(ApiEndpoint.logout, {});
    if (response != null && response.statusCode == 200) {
      apiService.clearToken();
      clearUser();
    }
  }

}
