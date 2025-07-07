import 'package:flutter/material.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import '../utils/file_downloader.dart';
import 'dart:io';

class FileDownloadWidget extends StatefulWidget {
  final String fileUrl;
  final String fileName;

  const FileDownloadWidget({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  @override
  State<FileDownloadWidget> createState() => _FileDownloadWidgetState();
}

class _FileDownloadWidgetState extends State<FileDownloadWidget> {
  bool _isLoading = false;
  bool _isDownloaded = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _checkIfFileAlreadyDownloaded();
  }

  Future<void> _checkIfFileAlreadyDownloaded() async {
    final path = await FileDownloader.getLocalFilePath(widget.fileName);
    final file = File(path);

    if (await file.exists()) {
      setState(() {
        _filePath = path;
        _isDownloaded = true;
      });
    }
  }

  Future<void> _handleDownloadOrOpen() async {
    if (_isDownloaded && _filePath != null) {
      await FileDownloader.openFile(_filePath!);
      return;
    }

    setState(() => _isLoading = true);

    final path =
    await FileDownloader.downloadFile(widget.fileUrl, fileName: widget.fileName);

    if (path != null) {
      setState(() {
        _filePath = path;
        _isDownloaded = true;
      });
      await FileDownloader.openFile(path);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLoading ? null : _handleDownloadOrOpen,
      child: Center(
        child: _isLoading
            ? SizedBox(
          width: MtcApp.appDimens.mediumIconSize,
          height: MtcApp.appDimens.mediumIconSize,
          child: const CircularProgressIndicator(),
        )
            : Icon(
          _isDownloaded ? Icons.visibility : Icons.download,
          size: MtcApp.appDimens.mediumIconSize,
        ),
      ),
    );
  }
}
