import 'dart:convert';

import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/chats/chats_response.dart';
import 'package:mtc/api/models/login/login_response.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/resource/params.dart';
import 'package:mtc/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsPageController extends GetxController {
  final apiService = Get.find<ApiService>();

  User? userData;
  var isUserSuperAdmin = false.obs;
  var allChats = <ChatsResponse>[].obs;
  var showChatLoading = true.obs;


  void init() async {
    userData = await getUser();
    if (userData?.roleType == "superadmin") {
      isUserSuperAdmin.value = true;
    } else {
      isUserSuperAdmin.value = false;
    }
    callChatsApi();
  }

  void callChatsApi()async {
    showChatLoading.value = true;
    final response = await apiService.get(ApiEndpoint.chats);
    if (response != null && response.statusCode == 200) {
      final List<ChatsResponse> chatsList = List<ChatsResponse>.from((response.data['data'] as List).map((x) => ChatsResponse.fromJson(x)));
      allChats.clear();
      allChats.addAll(chatsList);
    }
    showChatLoading.value = false;
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

  void openChatUserPage(ChatsResponse chat){
    Get.toNamed(AppRoutes.CHAT_USER_PAGE,arguments: {Params.chatData : chat});
  }
}
