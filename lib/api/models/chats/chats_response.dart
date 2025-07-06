class ChatsResponse {
  int? id;
  String? name;
  String? username;
  String? nationalCode;
  Null? studyFieldId;
  String? roleType;

  ChatsResponse(
      {this.id,
        this.name,
        this.username,
        this.nationalCode,
        this.studyFieldId,
        this.roleType});

  ChatsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    nationalCode = json['national_code'];
    studyFieldId = json['study_field_id'];
    roleType = json['role_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['national_code'] = nationalCode;
    data['study_field_id'] = studyFieldId;
    data['role_type'] = roleType;
    return data;
  }
}
