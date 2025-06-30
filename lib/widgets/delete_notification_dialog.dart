import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/models/news/news_request.dart';
import 'package:mtc/api/models/news/news_response.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/utils/persian_date_time_picker.dart';
import 'package:mtc/utils/utils.dart';

class DeleteNotificationDialog extends StatelessWidget {
  final RxBool showLoading;
  final VoidCallback? onDelete;

  DeleteNotificationDialog({super.key, required this.showLoading, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MtcApp.appDimens.mediumSpace),
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MtcApp.appDimens.xSmallSpace),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.mediumSpace))),
          child: Wrap(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(child: SizedBox()),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: AppColor.tDarkBlueColor, size: MtcApp.appDimens.mediumIconSize),
                  ),
                ],
              ),
              Center(
                child: Text(
                  AppString.areYouSureToDeleteNotification,
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.mediumFontSize),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MtcApp.appDimens.largeSpace),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (onDelete != null) {
                            onDelete!.call();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: MtcApp.appDimens.xSmallSpace),
                          decoration: BoxDecoration(
                            color: AppColor.bRedColor,
                            borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.xSmallSpace)),
                          ),
                          child: Center(
                            child: Obx(
                              () => Visibility(
                                visible: showLoading.value,
                                replacement: Text(
                                  AppString.deleteNewNotifications,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                                ),
                                child: CircularProgressIndicator(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MtcApp.appDimens.xSmallSpace),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: MtcApp.appDimens.xSmallSpace),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColor.bRedColor),
                            borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.xSmallSpace)),
                          ),
                          child: Center(
                            child: Text(
                              AppString.cancel,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColor.tRedColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
