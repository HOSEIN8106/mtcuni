class ChartResponse {
  int? id;
  String? title;
  String? subTitle;
  String? downloadLink;
  String? degreeLevel;
  StudyField? studyField;

  ChartResponse({this.id, this.title, this.subTitle, this.downloadLink, this.degreeLevel, this.studyField});

  ChartResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    downloadLink = json['download_link'];
    degreeLevel = json['degree_level'];
    studyField = json['study_field'] != null ? new StudyField.fromJson(json['study_field']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['download_link'] = downloadLink;
    data['degree_level'] = degreeLevel;
    if (studyField != null) {
      data['study_field'] = studyField!.toJson();
    }
    return data;
  }
}

class StudyField {
  int? id;
  String? title;

  StudyField({this.id, this.title});

  StudyField.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
