class videoDetailModel {
  String? message;
  Data? data;

  videoDetailModel({this.message, this.data});

  videoDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  String? videoUrl;
  String? coverImageUrl;
  int? status;
  String? categories;
  String? runningTime;
  String? type;
  Null? film;
  Null? article;
  int? tag;
  List<Comment>? comment;

  Data(
      {this.id,
        this.title,
        this.description,
        this.videoUrl,
        this.coverImageUrl,
        this.status,
        this.categories,
        this.runningTime,
        this.type,
        this.film,
        this.article,
        this.tag,
        this.comment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    videoUrl = json['video_url'];
    coverImageUrl = json['cover_image_url'];
    status = json['status'];
    categories = json['categories'];
    runningTime = json['running_time'];
    type = json['type'];
    film = json['film'];
    article = json['article'];
    tag = json['tag'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video_url'] = this.videoUrl;
    data['cover_image_url'] = this.coverImageUrl;
    data['status'] = this.status;
    data['categories'] = this.categories;
    data['running_time'] = this.runningTime;
    data['type'] = this.type;
    data['film'] = this.film;
    data['article'] = this.article;
    data['tag'] = this.tag;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  String? comment;
  String? user;
  String? avatar;
  String? createdAt;
  List<Null>? reply;

  Comment(
      {this.id,
        this.comment,
        this.user,
        this.avatar,
        this.createdAt,
        this.reply});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    user = json['user'];
    avatar = json['avatar'];
    createdAt = json['created_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['user'] = this.user;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;

    return data;
  }
}
