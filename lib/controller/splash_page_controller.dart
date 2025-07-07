import 'package:get/get.dart';
import 'package:mtc/routes/app_routes.dart';

class SplashPageController extends GetxController {
  void init() {
    Future.delayed(Duration(seconds: 4), () {
      openHomePage();
    });
  }

  void openHomePage() async {
    // to close all dialogs and bottom sheets
    Get.offAllNamed(AppRoutes.MAIN_PAGE);
  }
}
