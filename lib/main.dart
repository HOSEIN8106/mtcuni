import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/mtc_app.dart';

void main() async{
  Get.put(ApiService()); // Registering globally
  await Get.putAsync(() => ApiService().init());
  runApp(MtcApp());
}
