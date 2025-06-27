import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/academic_chart_page_controller.dart';
import 'package:mtc/enumerations/device_type.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_dimens.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/widgets/chart_item.dart';

class AcademicChartPage extends StatelessWidget {
  AcademicChartPage({super.key});

  AcademicChartPageController controller = Get.find<AcademicChartPageController>();

  @override
  Widget build(BuildContext context) {
    controller.init();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColor.darkBlue, borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace))),
              margin: EdgeInsets.symmetric(horizontal: MtcApp.appDimens.xxxLargeSpace, vertical: MtcApp.appDimens.largeSpace),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace)),
                child: DefaultTabController(
                  initialIndex: 1,
                  length: 2,
                  child: TabBar(
                    onTap: controller.handleTabClick,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    overlayColor: WidgetStateColor.transparent,
                    indicator: BoxDecoration(
                      color: AppColor.darkBlue500,
                      borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace)),
                    ),
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: MtcApp.appDimens.xRegularFontSize,
                      fontFamily: Constant.yekanFontFamily,
                    ),
                    tabs: [Tab(text: AppString.bachelorsDegree), Tab(text: AppString.associateDegree)],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.accentColor,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
                      child: Text(
                        AppString.academicChart,
                        style: TextStyle(color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.xMediumFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(() => Visibility(
                      visible: controller.isShowLoading.value,
                      replacement: Container(
                        margin: EdgeInsets.only(
                          right: MtcApp.appDimens.mediumSpace,
                          left: MtcApp.appDimens.mediumSpace,
                          bottom: MtcApp.appDimens.mediumSpace,
                        ),
                        padding: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.smallSpace))),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ChartItem(data: controller.chartData[index],);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(color: AppColor.gray100Color, thickness: MtcApp.appDimens.dividerHeight);
                          },
                          itemCount: controller.chartData.length,
                        ),
                      ), child: CircularProgressIndicator(),
                    ),),
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
