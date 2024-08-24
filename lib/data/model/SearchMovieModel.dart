class SearchMovieModel {
  int? code;
  String? status;
  List<Data>? data;

  SearchMovieModel({this.code, this.status, this.data});

  SearchMovieModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? releaseDate;
  String? poster;
  String? rating;
  int? ratePeople;
  String? type;
  int? totalEpisode;

  Data(
      {this.id,
        this.title,
        this.releaseDate,
        this.poster,
        this.rating,
        this.ratePeople,
        this.type,
        this.totalEpisode
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    releaseDate = json['release_date'];
    poster = json['poster'];
    rating = json['rating'];
    ratePeople = json['rate_people'];
    type = json['type'];
    totalEpisode = json['total_episode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['poster'] = this.poster;
    data['rating'] = this.rating;
    data['rate_people'] = this.ratePeople;
    data['type'] = this.type;
    data['total_episode'] = this.totalEpisode;
    return data;
  }
}
