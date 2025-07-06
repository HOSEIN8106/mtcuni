import 'package:flutter/material.dart';
import 'package:mtc/api/models/chats/chats_response.dart';
import 'package:mtc/mtc_app.dart';
import 'package:mtc/resource/app_color.dart';

class ChatItem extends StatelessWidget {
  final ChatsResponse chatsResponse;

  const ChatItem({super.key, required this.chatsResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MtcApp.appDimens.smallSpace),
      padding: EdgeInsets.all(MtcApp.appDimens.xSmallSpace),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MtcApp.appDimens.xSmallSpace),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, spreadRadius: 0, offset: Offset(0, 4))],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            width: MtcApp.appDimens.xxLargeSpace,
            height: MtcApp.appDimens.xxLargeSpace,
            child: Center(
              child:  Text(
                chatsResponse.name?[0] ?? '',
                textDirection: TextDirection.rtl,
                style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
              ),
            ),
          ),
          SizedBox(width: MtcApp.appDimens.smallSpace),
          Text(
            chatsResponse.name ?? '',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: AppColor.tDarkBlueColor, fontWeight: FontWeight.bold, fontSize: MtcApp.appDimens.xMediumFontSize),
          ),
        ],
      ),
    );
  }
}
