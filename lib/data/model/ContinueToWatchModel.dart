class ContinueToWatchModel {
  int? code;
  String? status;
  List<Data>? data;

  ContinueToWatchModel({this.code, this.status, this.data});

  ContinueToWatchModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? films;
  String? poster;
  String? episodes;
  int? progressing;
  String? duration;
  String? url;
  String? film_id;
  bool? subtitle;

  Data(
      {this.id,
        this.userId,
        this.films,
        this.poster,
        this.episodes,
        this.progressing,
        this.duration,
        this.url,
        this.film_id,
        this.subtitle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    films = json['films'];
    poster = json['poster'];
    episodes = json['episodes'];
    progressing = json['progressing'];
    duration = json['duration'];
    url = json['url'];
    film_id = json['film_id'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['films'] = this.films;
    data['poster'] = this.poster;
    data['episodes'] = this.episodes;
    data['progressing'] = this.progressing;
    data['duration'] = this.duration;
    data['url'] = this.url;
    data['film_id'] = this.film_id;
    data['subtitle'] = this.subtitle;
    return data;
  }
}
