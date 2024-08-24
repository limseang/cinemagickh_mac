class ArtistDetailModel {
  String? message;
  Data? data;

  ArtistDetailModel({this.message, this.data});

  ArtistDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}



class Data {
  int? id;
  String? name;
  String? bob;
  String? dod;
  int? country_id;
  String? nationality;
  String? nationalityLogo;
  String? gender;
  String? profile;
  String? biography;
  String? knowFor;
  List<Film>? film;
  String? status;

  Data(
      {this.id,
        this.name,
        this.bob,
        this.dod,
        this.country_id,
        this.nationality,
        this.nationalityLogo,
        this.gender,
        this.profile,
        this.biography,
        this.knowFor,
        this.film,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bob = json['bob'];
    dod = json['dod'];
    country_id = json['country_id'];
    nationality = json['nationality'];
    nationalityLogo = json['nationality_logo'];
    gender = json['gender'];
    profile = json['profile'];
    biography = json['biography'];
    knowFor = json['know_for'];
    if (json['film'] != null) {
      film = <Film>[];
      json['film'].forEach((v) {
        film!.add(new Film.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bob'] = this.bob;
    data['dod'] = this.dod;
    data['country_id'] = this.country_id;
    data['nationality'] = this.nationality;
    data['nationality_logo'] = this.nationalityLogo;
    data['gender'] = this.gender;
    data['profile'] = this.profile;
    data['biography'] = this.biography;
    data['know_for'] = this.knowFor;
    if (this.film != null) {
      data['film'] = this.film!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Film {
  int? id;
  String? title;
  String? poster;

  Film({this.id, this.title, this.poster});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['poster'] = this.poster;
    return data;
  }
}

class ArtistsResponse {
  final Map<String, List<Data>> data;

  ArtistsResponse({required this.data});

  factory ArtistsResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<Data>> data = {};
    json['data'].forEach((country, artistsJson) {
      List<Data> artists = [];
      for (var artistJson in artistsJson) {
        artists.add(Data.fromJson(artistJson));
      }
      data[country] = artists;
    });
    return ArtistsResponse(data: data);
  }
}


class ArtistDetailModel2 {
  int? id;
  String? name;
  String? nationality;
  String? nationalityLogo;
  String? profile;
  String? status;
  int? current_page;
  int? last_page;
  int? total;
  int? per_page;

  ArtistDetailModel2(
      {this.id,
        this.name,
        this.nationality,
        this.nationalityLogo,
        this.profile,
        this.status,
        this.current_page,
        this.last_page,
        this.total,});

  ArtistDetailModel2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationality = json['nationality'];
    nationalityLogo = json['nationality_logo'];
    profile = json['profile'];
    status = json['status'];
    current_page = json['current_page'];
    last_page = json['last_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nationality'] = this.nationality;
    data['nationality_logo'] = this.nationalityLogo;
    data['profile'] = this.profile;
    data['status'] = this.status;
    data['current_page'] = this.current_page;
    data['last_page'] = this.last_page;
    data['total'] = this.total;
    return data;
  }
}