import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/home_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/widgets/login_dialog.dart';
import 'package:mtc/widgets/news_item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomePageController controller = Get.find<HomePageController>();

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(!Constant.isUserLogin.value){
                        controller.openLoginDialog();
                      }else{

                      }
                    },
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(Icons.account_circle, size: MtcApp.appDimens.largeIconSize, color: Colors.white),
                        SizedBox(width: MtcApp.appDimens.smallSpace),
                        Obx(
                          () => Text(
                            Constant.isUserLogin.value ? controller.userData?.name ?? '' : AppString.goToPortal,
                            style: TextStyle(color: Colors.white, fontSize: MtcApp.appDimens.mediumFontSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Obx(
                    () => Visibility(
                      visible: Constant.isUserLogin.value,
                      child: GestureDetector(
                        onTap: controller.callLogoutApi,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(MtcApp.appDimens.tinySpace),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Center(child: Icon(Icons.logout, color: AppColor.redColor, size: MtcApp.appDimens.standardIconSize)),
                        ),
                      ),
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
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
                      child: Text(
                        AppString.newsAndNotifications,
                        style: TextStyle(color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.xMediumFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(() => Visibility(
                      visible: controller.showLoading.value,
                      replacement: Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: MtcApp.appDimens.mediumSpace),
                          child: ListView.builder(
                            itemCount: controller.allNews.length,
                            itemBuilder: (context, index) {
                              return NewsItem(data: controller.allNews[index],);
                            },
                          ),
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
