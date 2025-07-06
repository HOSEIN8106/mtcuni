class SendMessageRequest {
  String? message;
  int? userId;

  SendMessageRequest({this.message, this.userId});

  SendMessageRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['user_id'] = userId;
    return data;
  }
}
