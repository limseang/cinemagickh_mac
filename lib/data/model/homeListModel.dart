class HomeListModel {
  int? code;
  String? status;
  Data? data;

  HomeListModel({this.code, this.status, this.data});

  HomeListModel.fromJson(Map<String, dynamic> json) {
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
  List<NowShowing>? nowShowing;
  List<ComingSoon>? comingSoon;
  List<MostWatch>? mostWatch;
  List<Articles>? articles;

  Data({this.nowShowing, this.comingSoon, this.mostWatch});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['now_showing'] != null) {
      nowShowing = <NowShowing>[];
      json['now_showing'].forEach((v) {
        nowShowing!.add(new NowShowing.fromJson(v));
      });
    }
    if (json['coming_soon'] != null) {
      comingSoon = <ComingSoon>[];
      json['coming_soon'].forEach((v) {
        comingSoon!.add(new ComingSoon.fromJson(v));
      });
    }
    if (json['most_watch'] != null) {
      mostWatch = <MostWatch>[];
      json['most_watch'].forEach((v) {
        mostWatch!.add(new MostWatch.fromJson(v));
      });
    }
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nowShowing != null) {
      data['now_showing'] = this.nowShowing!.map((v) => v.toJson()).toList();
    }
    if (this.comingSoon != null) {
      data['coming_soon'] = this.comingSoon!.map((v) => v.toJson()).toList();
    }
    if (this.mostWatch != null) {
      data['most_watch'] = this.mostWatch!.map((v) => v.toJson()).toList();
    }
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NowShowing {
  int? id;
  String? name;
  String? rating;
  String? releaseDate;
  String? type;
  String? poster;
  bool? subtitle = false;

  NowShowing(
      {this.id,
        this.name,
        this.rating,
        this.releaseDate,
        this.type,
        this.poster});

  NowShowing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    type = json['type'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['release_date'] = this.releaseDate;
    data['type'] = this.type;
    data['poster'] = this.poster;
    return data;
  }
}
class ComingSoon {
  int? id;
  String? name;
  String? rating;
  String? releaseDate;
  String? type;
  String? poster;
  bool? subtitle = false;

  ComingSoon(
      {this.id,
        this.name,
        this.rating,
        this.releaseDate,
        this.type,
        this.poster});

  ComingSoon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    type = json['type'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['release_date'] = this.releaseDate;
    data['type'] = this.type;
    data['poster'] = this.poster;
    return data;
  }
}
class MostWatch {
  int? id;
  String? name;
  String? rating;
  String? releaseDate;
  String? type;
  String? poster;
  int? totalEpisode;
  bool? subtitle;

  MostWatch(
      {this.id,
        this.name,
        this.rating,
        this.releaseDate,
        this.type,
        this.poster,
        this.totalEpisode,
        this.subtitle
      });

  MostWatch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    releaseDate = json['release_date'];
    type = json['type'];
    poster = json['poster'];
    totalEpisode = json['total_episode'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['release_date'] = this.releaseDate;
    data['type'] = this.type;
    data['poster'] = this.poster;
    data['total_episode'] = this.totalEpisode;
    data['subtitle'] = this.subtitle;
    return data;
  }
}
class Articles {
  int? id;
  String? title;
  String? image;
  String? description;
  String? type;

  Articles({this.id, this.title, this.image, this.description, this.type});

  Articles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}
