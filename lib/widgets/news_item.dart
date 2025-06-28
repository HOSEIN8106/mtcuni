import 'package:flutter/material.dart';
import 'package:mtc/api/models/news/news_response.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';
import 'package:mtc/utils/utils.dart';

class NewsItem extends StatelessWidget {
  final NewsResponse data;
  final bool? isEditable;
  final VoidCallback? onEditClick;
  final VoidCallback? onDeleteClick;

  const NewsItem({super.key, required this.data, this.isEditable = false, this.onEditClick, this.onDeleteClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.openUrl(data.link);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: MtcApp.appDimens.smallSpace),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(MtcApp.appDimens.xSmallSpace)),
        child: Padding(
          padding: EdgeInsets.all(MtcApp.appDimens.xSmallSpace),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      style: TextStyle(color: AppColor.tDarkBlueColor, fontSize: MtcApp.appDimens.mediumFontSize, fontWeight: FontWeight.bold),
                    ),
                    Text(data.description ?? '', style: TextStyle(color: AppColor.tGrayColor, fontSize: MtcApp.appDimens.xRegularFontSize)),
                  ],
                ),
              ),
              Visibility(
                visible: isEditable ?? false,
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    InkWell(
                      onTap: () {
                        if (onEditClick != null) {
                          onEditClick!.call();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(MtcApp.appDimens.smallSpace),
                        child: Icon(Icons.edit, color: AppColor.darkBlueColor, size: MtcApp.appDimens.mediumIconSize),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (onDeleteClick != null) {
                          onDeleteClick!.call();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(MtcApp.appDimens.smallSpace),
                        child: Icon(Icons.delete, color: AppColor.darkBlueColor, size: MtcApp.appDimens.mediumIconSize),
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
