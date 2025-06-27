import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/class_schedule_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/widgets/lesson_item.dart';

class ClassSchedulePage extends StatelessWidget {
  ClassSchedulePage({super.key});

  ClassSchedulePageController controller = Get.find<ClassSchedulePageController>();

  @override
  Widget build(BuildContext context) {
    controller.init();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          AppString.timeToStartClassLessons,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                        ),
                      ),
                      Center(
                        child: Text(
                          AppString.weeklyPlanForComputer,
                          style: TextStyle(color: Colors.white, fontSize: MtcApp.appDimens.xRegularFontSize),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      if(Constant.isUserLogin.value){
                        controller.openMyClassSchedulePage();
                      }else{
                        controller.openLoginDialog();
                      }
                    },
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          AppString.myClassSchedule,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xRegularFontSize),
                        ),
                        SizedBox(width: MtcApp.appDimens.smallSpace),
                        Icon(Icons.contact_page_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MtcApp.appDimens.mediumSpace),
                    topRight: Radius.circular(MtcApp.appDimens.mediumSpace),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
                      child: TextField(
                        onChanged: (value) => controller.filterLessons(value),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: AppColor.bGreenColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace)),
                            borderSide: BorderSide(width: MtcApp.appDimens.dividerHeight, color: AppColor.bGreenColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace)),
                            borderSide: BorderSide(width: MtcApp.appDimens.dividerHeight, color: AppColor.bGreenColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace)),
                            borderSide: BorderSide(width: MtcApp.appDimens.dividerHeight),
                          ),
                          hintText: AppString.search,
                          hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.lessonLoading.value,
                        replacement: Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: MtcApp.appDimens.mediumSpace),
                            child: ListView.builder(
                              itemCount: controller.filteredLessons.length,
                              itemBuilder: (context, index) {
                                return LessonItem(
                                  lessonsResponse: controller.filteredLessons[index],
                                  onShowItemClick: () {
                                    controller.openDetailLessonChartBottomSheet(controller.filteredLessons[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
