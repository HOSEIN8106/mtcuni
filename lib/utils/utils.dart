import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mtc/enumerations/snack_bar_type.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String replaceDashToNull(String? value) {
    try {
      return value == null || value == "" || value == "null" ? "-" : value;
    } catch (e) {
      return "-";
    }
  }

  static void showSnackBar(String message, {SnackBarType snackBarType = SnackBarType.error, isShowLongDuration = false, VoidCallback? onClosed}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        overlayBlur: 5.5,
        duration: Duration(seconds: isShowLongDuration ? 4 : 2),
        forwardAnimationCurve: Curves.fastOutSlowIn,
        boxShadows: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 8, spreadRadius: 0, offset: Offset(0, 4))],
        backgroundColor: Colors.white,
        borderRadius: MtcApp.appDimens.smallSpace,
        margin: EdgeInsets.only(top: MtcApp.appDimens.xxLargeSpace, left: MtcApp.appDimens.mediumSpace, right: MtcApp.appDimens.mediumSpace),
        messageText: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color:
                    snackBarType == SnackBarType.error
                        ? Colors.red
                        : snackBarType == SnackBarType.info
                        ? Colors.blue
                        : snackBarType == SnackBarType.warning
                        ? Colors.blue
                        : Colors.green,
                size: MtcApp.appDimens.mediumIconSize,
              ),
              SizedBox(height: MtcApp.appDimens.xSmallSpace),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.w500, fontSize: MtcApp.appDimens.xRegularFontSize),
              ),
            ],
          ),
        ),
        snackbarStatus: (value) {
          if (value == SnackbarStatus.CLOSED) {
            if (onClosed != null) {
              onClosed();
            }
          }
        },
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  static String formatDateTime(DateTime dateTime) {
    final formatter = intl.DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(dateTime);
  }

  static Future openUrl(String? value, {LaunchMode launchMode = LaunchMode.externalApplication}) async {
    if (value != null) {
      await launchUrl(Uri.parse(value), mode: launchMode);
    } else {
      throw 'Could not launch null url';
    }
  }
}
