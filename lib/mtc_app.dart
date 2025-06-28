import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as getx;
import 'package:mtc/theme/app_theme.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'resource/app_color.dart';
import 'resource/app_dimens.dart';
import 'resource/app_string.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class MtcApp extends StatelessWidget {
  static AppDimens appDimens = AppDimens();

  @override
  Widget build(BuildContext context) {
    //fix transparent appbar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppDimens.initAppDimen();
    });
    //fix orientation change
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
        builder: (context, childId) {
          // disable system font setting
          return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: childId!);
        },
      locale: const Locale("en", "US"),
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"),
      ],
      localizationsDelegates: const [
        // Add Localization
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
      ],
        title: AppString.appName,
        theme: appThemeData,
        debugShowCheckedModeBanner: true,
        initialRoute: AppRoutes.INITIAL,
        getPages: AppPages.pages,
        defaultTransition: getx.Transition.cupertino,
    );
  }
}
