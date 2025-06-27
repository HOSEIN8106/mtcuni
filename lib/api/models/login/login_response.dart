class LoginResponse {
  String? token;
  User? user;

  LoginResponse({this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? nationalCode;
  int? studyFieldId;
  String? roleType;

  User({this.id, this.name, this.username, this.nationalCode, this.studyFieldId, this.roleType});

  User.fromJson(Map<String, dynamic> json) {
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
