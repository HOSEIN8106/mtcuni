import 'package:get/get.dart';
import 'package:mtc/controller/academic_chart_page_controller.dart';
import 'package:mtc/controller/chats_page_controller.dart';
import 'package:mtc/controller/home_page_controller.dart';
import 'package:mtc/controller/class_schedule_page_controller.dart';
import 'package:mtc/controller/main_page_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() {
      return MainPageController();
    });
    Get.lazyPut<HomePageController>(() {
      return HomePageController();
    });

    Get.lazyPut<ChatsPageController>(() {
      return ChatsPageController();
    });

    Get.lazyPut<AcademicChartPageController>(() {
      return AcademicChartPageController();
    });

    Get.lazyPut<ClassSchedulePageController>(() {
      return ClassSchedulePageController();
    });
  }
}
