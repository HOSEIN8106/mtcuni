import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/models/news/news_request.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/resource/app_string.dart';
import 'package:mtc/utils/persian_date_time_picker.dart';
import 'package:mtc/utils/utils.dart';

class NotificationDialog extends StatelessWidget {
  final Function(NewsRequest) onCreate;
  final RxBool showLoading;

  NotificationDialog({super.key, required this.onCreate, required this.showLoading});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  NewsRequest? newsRequest;
  String? dateTime;

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
                  Expanded(
                    child: Center(
                      child: Text(
                        AppString.newNotifications,
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.mediumFontSize),
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close, color: AppColor.tDarkBlueColor, size: MtcApp.appDimens.mediumIconSize),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: MtcApp.appDimens.mediumSpace, bottom: MtcApp.appDimens.xSmallSpace),
                child: TextField(
                  controller: titleController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                    hintText: AppString.titleNotification,
                    hintStyle: TextStyle(fontSize: MtcApp.appDimens.mediumFontSize, color: AppColor.gray200Color),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                child: TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                    hintText: AppString.descriptionNotification,
                    hintStyle: TextStyle(fontSize: MtcApp.appDimens.mediumFontSize, color: AppColor.gray200Color),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                child: TextField(
                  controller: linkController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                    hintText: AppString.linkNotification,
                    hintStyle: TextStyle(fontSize: MtcApp.appDimens.mediumFontSize, color: AppColor.gray200Color),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                child: TextField(
                  onTap: () async {
                    final result = await showPersianDateTimePickerFormatted(context: context);
                    dateTime = result;
                    dateController.text = formatGregorianToPersian(result ?? '');
                  },
                  controller: dateController,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                    hintText: AppString.expireNotification,
                    hintStyle: TextStyle(fontSize: MtcApp.appDimens.mediumFontSize, color: AppColor.gray200Color),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  newsRequest = NewsRequest(
                    title: titleController.text,
                    description: descriptionController.text,
                    link: linkController.text,
                    expireAt: dateTime,
                  );
                  if (newsRequest != null &&
                      titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      linkController.text.isNotEmpty &&
                      dateController.text.isNotEmpty) {
                    onCreate.call(newsRequest!);
                  } else {
                    Utils.showSnackBar(AppString.pleaseFillInputText);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(MtcApp.appDimens.mediumSpace),
                  padding: EdgeInsets.symmetric(vertical: MtcApp.appDimens.xSmallSpace),
                  decoration: BoxDecoration(
                    color: AppColor.bGreenColor,
                    borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.xSmallSpace)),
                  ),
                  child: Center(
                    child: Obx(
                      () => Visibility(
                        visible: showLoading.value,
                        replacement: Text(
                          AppString.login,
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
            ],
          ),
        ),
      ),
    );
  }
}
