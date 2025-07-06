import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/chats_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/resource/constant.dart';
import 'package:mtc/widgets/chat_item.dart';

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
                      visible: Constant.isUserLogin.value && controller.isUserSuperAdmin.value,
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
                            SizedBox(width: MtcApp.appDimens.smallSpace),
                            Icon(Icons.settings, color: Colors.white, size: MtcApp.appDimens.standardIconSize),
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
                  Obx(
                    () => Visibility(
                      visible: Constant.isUserLogin.value,
                      child: Visibility(
                        visible: controller.showChatLoading.value,
                        replacement: Container(
                          margin: EdgeInsets.only(
                            right: MtcApp.appDimens.mediumSpace,
                            left: MtcApp.appDimens.mediumSpace,
                            top: MtcApp.appDimens.xSmallSpace,
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.openChatUserPage(controller.allChats[index]);
                                },
                                child: ChatItem(chatsResponse: controller.allChats[index]),
                              );
                            },
                            itemCount: controller.allChats.length,
                          ),
                        ),
                        child: Padding(padding: EdgeInsets.only(top: MtcApp.appDimens.mediumSpace), child: CircularProgressIndicator()),
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
