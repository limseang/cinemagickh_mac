class FavoriteListModel {
  int? code;
  String? status;
  Data? data;

  FavoriteListModel({this.code, this.status, this.data});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
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
  int? lastPage;
  int? perPage;
  int? total;
  List<Favorite>? favorite;

  Data(
      {this.currentPage,
        this.lastPage,
        this.perPage,
        this.total,
        this.favorite});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    if (json['favorite'] != null) {
      favorite = <Favorite>[];
      json['favorite'].forEach((v) {
        favorite!.add(new Favorite.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    if (this.favorite != null) {
      data['favorite'] = this.favorite!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorite {
  int? farvoriteId;
  int? id;
  String? title;
  String? releaseDate;
  String? rating;
  String? poster;
  String? type;
  String? createdAt;

  Favorite(
      {this.farvoriteId,
        this.id,
        this.title,
        this.releaseDate,
        this.rating,
        this.poster,
        this.type,
        this.createdAt});

  Favorite.fromJson(Map<String, dynamic> json) {
    farvoriteId = json['farvorite_id'];
    id = json['id'];
    title = json['title'];
    releaseDate = json['release_date'];
    rating = json['rating'];
    poster = json['poster'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['farvorite_id'] = this.farvoriteId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['rating'] = this.rating;
    data['poster'] = this.poster;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
