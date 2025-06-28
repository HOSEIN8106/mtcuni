class NewsRequest {
  String? title;
  String? description;
  String? link;
  String? expireAt;

  NewsRequest({this.title, this.description, this.link, this.expireAt});

  NewsRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    link = json['link'];
    expireAt = json['expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['link'] = link;
    data['expire_at'] = expireAt;
    return data;
  }
}
