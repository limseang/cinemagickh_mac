class CastDetailModel {
  String? message;
  Data? data;

  CastDetailModel({this.message, this.data});

  CastDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? filmId;
  int? actorId;
  String? actorName;
  String? character;
  String? position;
  String? image;
  String? status;

  Data(
      {this.id,
        this.filmId,
        this.actorId,
        this.actorName,
        this.character,
        this.position,
        this.image,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filmId = json['film_id'];
    actorId = json['actor_id'];
    actorName = json['actor_name'];
    character = json['character'];
    position = json['position'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['film_id'] = this.filmId;
    data['actor_id'] = this.actorId;
    data['actor_name'] = this.actorName;
    data['character'] = this.character;
    data['position'] = this.position;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
