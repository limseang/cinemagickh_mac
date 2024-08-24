class WatchMovieListModel {
  int? code;
  String? status;
  Data? data;

  WatchMovieListModel({this.code, this.status, this.data});

  WatchMovieListModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  int? totalPages;
  int? totalCount;
  List<FilmInWatchMovie>? films;

  Data({this.currentPage, this.totalPages, this.totalCount, this.films});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalCount = json['total_count'];
    if (json['films'] != null) {
      films = <FilmInWatchMovie>[];
      json['films'].forEach((v) {
        films!.add(new FilmInWatchMovie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_count'] = this.totalCount;
    if (this.films != null) {
      data['films'] = this.films!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilmInWatchMovie {
  int? id;
  String? title;
  String? releaseDate;
  String? poster;
  String? rating;
  int? ratePeople;
  String? type;
  int? totalEpisode;

  FilmInWatchMovie(
      {this.id,
        this.title,
        this.releaseDate,
        this.poster,
        this.rating,
        this.ratePeople,
        this.type,
        this.totalEpisode
      });

  FilmInWatchMovie.fromJson(Map<String, dynamic> json) {
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
