class NewsResponse {
  int? id;
  String? title;
  String? description;
  String? link;
  String? expireAt;

  NewsResponse({this.id, this.title, this.description, this.link, this.expireAt});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    expireAt = json['expire_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['link'] = link;
    data['expire_at'] = expireAt;
    return data;
  }
}
