import 'package:get/get.dart';
import 'package:mtc/controller/notification_manager_page_controller.dart';

class NotificationManagerPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationManagerPageController());
  }
}
