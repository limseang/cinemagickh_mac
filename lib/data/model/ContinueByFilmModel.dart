class ContinueByFilmModel {
  int? code;
  String? status;
  Data? data;

  ContinueByFilmModel({this.code, this.status, this.data});

  ContinueByFilmModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? description;
  String? poster;
  List<Episodes>? episodes;

  Data({this.id, this.title, this.description, this.poster, this.episodes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    poster = json['poster'];
    if (json['episodes'] != null) {
      episodes = <Episodes>[];
      json['episodes'].forEach((v) {
        episodes!.add(new Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['poster'] = this.poster;
    if (this.episodes != null) {
      data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  int? id;
  int? continueId;
  String? episode;
  String? season;
  String? status;
  String? file;
  String? duration;
  String? progressing;
  String? percentage;

  Episodes(
      {this.id,
        this.continueId,
        this.episode,
        this.season,
        this.status,
        this.file,
        this.duration,
        this.progressing,
        this.percentage});

  Episodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    continueId = json['continue_id'];
    episode = json['episode'];
    season = json['season'];
    status = json['status'];
    file = json['file'];
    duration = json['duration'];
    progressing = json['progressing'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['continue_id'] = this.continueId;
    data['episode'] = this.episode;
    data['season'] = this.season;
    data['status'] = this.status;
    data['file'] = this.file;
    data['duration'] = this.duration;
    data['progressing'] = this.progressing;
    data['percentage'] = this.percentage;
    return data;
  }
}
