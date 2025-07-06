import 'package:flutter/material.dart';
import 'package:mtc/api/models/chart_response.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/widgets/file_download_widget.dart';

class ChartItem extends StatelessWidget {
  final ChartResponse data;

  const ChartItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.title ?? '',
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.mediumFontSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MtcApp.appDimens.smallSpace,),
              Text(data.subTitle ?? '', style: TextStyle(color: AppColor.tGrayColor, fontSize: MtcApp.appDimens.xRegularFontSize)),
            ],
          ),
        ),
        SizedBox(width: MtcApp.appDimens.mediumSpace,),
        FileDownloadWidget(fileUrl: data.downloadLink ?? '', fileName: "Mtc-${data.title}"),
      ],
    );
  }
}
