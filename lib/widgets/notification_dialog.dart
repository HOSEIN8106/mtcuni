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

class NotificationDialog extends StatelessWidget {
  final Function(NewsRequest) onCreate;
  final RxBool showLoading;
  final bool isUpdating;
  final NewsResponse? updateNewsData;
  final Function(int, NewsRequest)? onUpdate;

  NotificationDialog({super.key, required this.onCreate, this.isUpdating = false, required this.showLoading, this.onUpdate, this.updateNewsData});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  NewsRequest? newsRequest;
  String? dateTime;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (isUpdating) {
      titleController.text = updateNewsData?.title ?? '';
      descriptionController.text = updateNewsData?.description ?? '';
      linkController.text = updateNewsData?.link ?? '';
      dateController.text = formatGregorianToPersian(updateNewsData?.expireAt ?? '');
      dateTime = updateNewsData?.expireAt ?? '';
    }
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: MtcApp.appDimens.mediumSpace),
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MtcApp.appDimens.xSmallSpace),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(MtcApp.appDimens.mediumSpace))),
          child: Form(
            key: formKey,
            child: Wrap(
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          isUpdating ? AppString.updateNotifications : AppString.newNotifications,
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.mediumFontSize),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Get.back(),
                      child: Icon(Icons.close, color: AppColor.tDarkBlueColor, size: MtcApp.appDimens.mediumIconSize),
                    ),
                  ],
                ),

                /// Title
                Padding(
                  padding: EdgeInsets.only(top: MtcApp.appDimens.mediumSpace, bottom: MtcApp.appDimens.xSmallSpace),
                  child: TextFormField(
                    onTap: () {
                      final text = titleController.text;
                      titleController.selection = TextSelection.fromPosition(
                        TextPosition(offset: text.length),
                      );
                    },
                    controller: titleController,
                    textAlign: TextAlign.right,
                    validator: (value) => value!.isEmpty ? AppString.pleaseFillInputText : null,
                    decoration: _inputDecoration(AppString.titleNotification),
                  ),
                ),

                /// Description
                Padding(
                  padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                  child: TextFormField(
                    onTap: () {
                      final text = descriptionController.text;
                      descriptionController.selection = TextSelection.fromPosition(
                        TextPosition(offset: text.length),
                      );
                    },
                    controller: descriptionController,
                    textAlign: TextAlign.right,
                    validator: (value) => value!.isEmpty ? AppString.pleaseFillInputText : null,
                    decoration: _inputDecoration(AppString.descriptionNotification),
                  ),
                ),

                /// Link (URL Validation)
                Padding(
                  padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                  child: TextFormField(
                    onTap: () {
                      final text = linkController.text;
                      linkController.selection = TextSelection.fromPosition(
                        TextPosition(offset: text.length),
                      );
                    },
                    controller: linkController,
                    textAlign: TextAlign.right,
                    validator: validateUrl, // استفاده از تابع ولیدیشن جداگانه
                    decoration: _inputDecoration(AppString.linkNotification),
                  ),
                ),

                /// Date (readOnly)
                Padding(
                  padding: EdgeInsets.only(bottom: MtcApp.appDimens.xSmallSpace),
                  child: TextFormField(
                    onTap: () async {
                      final result = await showPersianDateTimePickerFormatted(context: context);
                      dateTime = result;
                      dateController.text = formatGregorianToPersian(result ?? '');
                    },
                    controller: dateController,
                    textAlign: TextAlign.right,
                    readOnly: true,
                    validator: (value) => value!.isEmpty ? AppString.pleaseFillInputText : null,
                    decoration: _inputDecoration(AppString.expireNotification),
                  ),
                ),

                /// Submit Button
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      newsRequest = NewsRequest(
                        title: titleController.text,
                        description: descriptionController.text,
                        link: linkController.text,
                        expireAt: dateTime,
                      );
                      if (isUpdating && onUpdate != null) {
                        onUpdate!.call(updateNewsData?.id ?? 0, newsRequest!);
                      } else {
                        onCreate.call(newsRequest!);
                      }
                    } else {
                      Utils.showSnackBar(AppString.pleaseFillInputText);
                    }
                  },
                  child: Container(
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
                            isUpdating ? AppString.updateNotifications : AppString.buildNotifications,
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
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
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
      hintText: hintText,
      hintStyle: TextStyle(fontSize: MtcApp.appDimens.mediumFontSize, color: AppColor.gray200Color),
    );
  }

  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'لینک را وارد کنید';
    }

    final urlPattern = r'^(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w\-.?=%&]*)*\/?$';
    final result = RegExp(urlPattern, caseSensitive: false).hasMatch(value);

    if (!result) {
      return 'لینک معتبر نیست';
    }

    return null;
  }
}
