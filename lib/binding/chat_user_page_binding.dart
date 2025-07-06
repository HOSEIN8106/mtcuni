import 'package:get/get.dart';
import 'package:mtc/controller/chat_user_page_controller.dart';

class ChatUserPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatUserPageController());
  }
}
