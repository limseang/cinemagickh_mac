class SubtitleModel {
  int? code;
  String? status;
  List<Data>? data;

  SubtitleModel({this.code, this.status, this.data});

  SubtitleModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? language;
  String? url;
  String? languageCode;
  String? status;

  Data({this.id, this.language, this.url, this.languageCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    url = json['url'];
    languageCode = json['language_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['url'] = this.url;
    data['language_code'] = this.languageCode;
    data['status'] = this.status;
    return data;
  }
}
