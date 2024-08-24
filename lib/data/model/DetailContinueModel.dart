class DetailContinueModel {
  int? code;
  String? status;
  Data? data;

  DetailContinueModel({this.code, this.status, this.data});

  DetailContinueModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? films;
  String? episodes;
  String? url;
  String? episodeId;
  int? progressing;
  String? duration;
  String? index;
  List<Subtitles>? subtitles;

  Data(
      {this.id,
        this.userId,
        this.films,
        this.episodes,
        this.url,
        this.episodeId,
        this.progressing,
        this.duration,
        this.index,
        this.subtitles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    films = json['films'];
    episodes = json['episodes'];
    url = json['url'];
    episodeId = json['episode_id'];
    progressing = json['progressing'];
    duration = json['duration'];
    index = json['index'];
    if (json['subtitles'] != null) {
      subtitles = <Subtitles>[];
      json['subtitles'].forEach((v) {
        subtitles!.add(new Subtitles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['films'] = this.films;
    data['episodes'] = this.episodes;
    data['url'] = this.url;
    data['episode_id'] = this.episodeId;
    data['progressing'] = this.progressing;
    data['duration'] = this.duration;
    data['index'] = this.index;
    if (this.subtitles != null) {
      data['subtitles'] = this.subtitles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subtitles {
  int? id;
  String? language;
  String? url;

  Subtitles({this.id, this.language, this.url});

  Subtitles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    language = json['language'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['language'] = this.language;
    data['url'] = this.url;
    return data;
  }
}
