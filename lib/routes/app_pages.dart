import 'package:get/get.dart';
import 'package:mtc/binding/academic_chart_page_binding.dart';
import 'package:mtc/binding/home_page_binding.dart';
import 'package:mtc/binding/class_schedule_page_binding.dart';
import 'package:mtc/binding/main_page_binding.dart';
import 'package:mtc/binding/chats_page_binding.dart';
import 'package:mtc/binding/my_class_schedule_page_binding.dart';
import 'package:mtc/binding/notification_manager_page_binding.dart';
import 'package:mtc/binding/splash_binding.dart';
import 'package:mtc/pages/academic_chart_page.dart';
import 'package:mtc/pages/home_page.dart';
import 'package:mtc/pages/class_schedule_page.dart';
import 'package:mtc/pages/main_page.dart';
import 'package:mtc/pages/chats_page.dart';
import 'package:mtc/pages/my_class_shedule_page.dart';
import 'package:mtc/pages/notification_manager_page.dart';
import 'package:mtc/routes/app_routes.dart';

import '../pages/spalsh_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.INITIAL, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(name: AppRoutes.MAIN_PAGE, page: () => MainPage(), binding: MainPageBinding()),
    GetPage(name: AppRoutes.CLASS_SCHEDULE_PAGE, page: () => ClassSchedulePage(), binding: ClassSchedulePageBinding()),
    GetPage(name: AppRoutes.MY_CLASS_SCHEDULE_PAGE, page: () => MyClassSchedulePage(), binding: MyClassSchedulePageBinding()),
    GetPage(name: AppRoutes.ACADEMIC_CHART_PAGE, page: () => AcademicChartPage(), binding: AcademicChartPageBinding()),
    GetPage(name: AppRoutes.CHATS_PAGE, page: () => ChatsPage(), binding: ChatsPageBinding()),
    GetPage(name: AppRoutes.HOME_PAGE, page: () => HomePage(), binding: HomePageBinding()),
    GetPage(name: AppRoutes.NOTIFICATION_MANAGER_PAGE, page: () => NotificationManagerPage(), binding: NotificationManagerPageBinding()),
  ];
}
