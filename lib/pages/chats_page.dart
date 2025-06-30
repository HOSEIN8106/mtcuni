import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/chats_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  ChatsPageController controller = Get.find<ChatsPageController>();

  @override
  Widget build(BuildContext context) {
    controller.init();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColor.primaryColor,
              padding: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Center(
                    child: Text(
                      AppString.chats,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Obx(
                    () => Visibility(
                      visible:Constant.isUserLogin.value && controller.isUserSuperAdmin.value,
                      child: GestureDetector(
                        onTap: () {
                          controller.openNotificationManagerPage();
                        },
                        child: Row(
                          children: [
                            Text(
                              AppString.manageNotifications,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                            ),
                            SizedBox(width: MtcApp.appDimens.smallSpace,),
                            Icon(Icons.settings,color: Colors.white,size: MtcApp.appDimens.standardIconSize,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Visibility(
                    visible: !Constant.isUserLogin.value,
                    child: Center(
                      child: Text(
                        AppString.loginForUse,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: Constant.isUserLogin.value,
                    child: Container(
                      margin: EdgeInsets.only(right: MtcApp.appDimens.mediumSpace, left: MtcApp.appDimens.mediumSpace, top: MtcApp.appDimens.xSmallSpace),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: MtcApp.appDimens.smallSpace),
                            padding: EdgeInsets.all(MtcApp.appDimens.xSmallSpace),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(MtcApp.appDimens.xSmallSpace),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                  width: MtcApp.appDimens.xxLargeSpace,
                                  height: MtcApp.appDimens.xxLargeSpace,
                                ),
                                SizedBox(width: MtcApp.appDimens.smallSpace),
                                Text(
                                  "حسین قباسفیدی",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
