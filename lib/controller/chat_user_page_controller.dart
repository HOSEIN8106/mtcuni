import 'dart:async';

import 'package:get/get.dart';
import 'package:mtc/api/api_endpoint.dart';
import 'package:mtc/api/api_service.dart';
import 'package:mtc/api/models/chats/chat_message_response.dart';
import 'package:mtc/api/models/chats/chats_response.dart';
import 'package:mtc/api/models/chats/send_message_request.dart';
import 'package:mtc/resource/params.dart';

class ChatUserPageController extends GetxController {
  final apiService = Get.find<ApiService>();

  RxList<ChatMessageResponse> allMessages = <ChatMessageResponse>[].obs;
  RxBool showChatLoading = true.obs;

  Timer? timer;
  Rxn<ChatsResponse> currentUser = Rxn<ChatsResponse>();

  @override
  void onInit() {
    super.onInit();
    currentUser.value = Get.arguments[Params.chatData];
    fetchMessages();
    timer = Timer.periodic(const Duration(seconds: 3), (_) => fetchMessages());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void fetchMessages() async {
    showChatLoading.value = true;
    Map<String, dynamic> data = {};
    data["user_id"] = currentUser.value?.id;
    final response = await apiService.get(ApiEndpoint.messages, query: data);
    if (response != null && response.statusCode == 200) {
      final List<ChatMessageResponse> messageList = List<ChatMessageResponse>.from(
        (response.data['data'] as List).map((x) => ChatMessageResponse.fromJson(x)),
      );
      allMessages.value = messageList;
    }
    showChatLoading.value = false;
  }

  void sendMessage(String text) async {
    SendMessageRequest sendMessageRequest = SendMessageRequest(message: text, userId: currentUser.value?.id);
    final response = await apiService.post(ApiEndpoint.sendMessage, sendMessageRequest.toJson());
    if (response != null && response.statusCode == 200) {
      fetchMessages();
    }
  }
}
