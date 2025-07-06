import 'dart:io';

import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static Future<String?> downloadFile(String url, {String? fileName}) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final name = fileName ?? url.split('/').last;
      final filePath = '${dir.path}/$name';

      final file = File(filePath);
      if (await file.exists()) return filePath;

      final dio = Dio();
      final response = await dio.download(url, filePath);

      if (response.statusCode == 200) {
        return filePath;
      }
    } catch (e) {
      print("Download error: $e");
    }
    return null;
  }

  static Future<void> openFile(String path) async {
    await OpenFilex.open(path);
  }
}
