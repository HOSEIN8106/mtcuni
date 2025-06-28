import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/controller/notification_manager_page_controller.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/widgets/news_item.dart';

class NotificationManagerPage extends StatelessWidget {
  NotificationManagerPage({super.key});

  NotificationManagerPageController controller = Get.find<NotificationManagerPageController>();

  @override
  Widget build(BuildContext context) {
    controller.init();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: AppColor.secondaryColor,
            onPressed: (){
              controller.openNotificationDialog();
            },
            child: Icon(Icons.add,size: MtcApp.appDimens.mediumIconSize,)
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: AppColor.primaryColor,
              padding: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    AppString.notificationsList,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, color: Colors.white, size: MtcApp.appDimens.mediumIconSize),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.showLoading.value,
                replacement: Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: MtcApp.appDimens.mediumSpace,
                      left: MtcApp.appDimens.mediumSpace,
                      top: MtcApp.appDimens.mediumSpace,
                    ),
                    child: ListView.builder(
                      itemCount: controller.allNews.length,
                      itemBuilder: (context, index) {
                        return NewsItem(
                          data: controller.allNews[index],
                          isEditable: true,
                          onDeleteClick: () {
                            //todo add code
                          },
                          onEditClick: () {
                            //todo add code
                          },
                        );
                      },
                    ),
                  ),
                ),
                child: Padding(padding: EdgeInsets.only(top: MtcApp.appDimens.mediumSpace), child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
