import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/chat_user_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';

class ChatUserPage extends StatelessWidget {
  ChatUserPage({super.key});

  ChatUserPageController controller = Get.find<ChatUserPageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColor.primaryColor,
              padding: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: MtcApp.appDimens.mediumSpace),
                      child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    width: MtcApp.appDimens.xxLargeSpace,
                    height: MtcApp.appDimens.xxLargeSpace,
                    child: Center(
                      child:  Text(
                        controller.currentUser.value?.name?[0] ?? '',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                      ),
                    ),
                  ),
                  SizedBox(width: MtcApp.appDimens.smallSpace,),
                  Center(
                    child:  Text(
                      controller.currentUser.value?.name ?? '',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MtcApp.appDimens.smallSpace,),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.allMessages.length,
                itemBuilder: (context, index) {
                  final msg = controller.allMessages[controller.allMessages.length - index - 1];
                  final isMe = msg.user?.id == controller.currentUser.value?.id;

                  return BubbleNormal(
                    text: msg.message ?? '',
                    isSender: !isMe,
                    color: !isMe ? Colors.greenAccent : Colors.grey[300]!,
                    tail: true,
                    textStyle: const TextStyle(fontSize: 16),
                  );
                },
              ),),
            ),
            MessageBar(
              onSend: (text) {
                controller.sendMessage(text);
              },
              messageBarColor: Colors.white,
              sendButtonColor: AppColor.bGreenColor,
              actions: [],
            ),
          ],
        ),
      ),
    );
  }
}
