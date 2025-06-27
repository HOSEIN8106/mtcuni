import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsPageController extends GetxController {
  User? userData;
  var isUserSuperAdmin = false.obs;

  void init() async {
    userData = await getUser();
    if (userData?.roleType == "superadmin") {
      isUserSuperAdmin.value = true;
    } else {
      isUserSuperAdmin.value = false;
    }
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(Constant.userData);
    if (userString != null) {
      return User.fromJson(jsonDecode(userString));
    }
    return null;
  }

  void openNotificationManagerPage() {
    Get.toNamed(AppRoutes.NOTIFICATION_MANAGER_PAGE);
  }
}
