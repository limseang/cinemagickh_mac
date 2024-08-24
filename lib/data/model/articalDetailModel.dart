class articalDetailModel {
  String? message;
  Data? data;

  articalDetailModel({this.message, this.data});

  articalDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? origin;
  String? originPageId;
  String? originLogo;
  String? originLink;
  String? type;
  int? like;
  int? commentCount;
  String? share;
  String? view;
  Null? film;
  String? image;
  int? bookmark;
  List<Comment>? comment;
  List<Category>? category;

  Data(
      {this.id,
        this.title,
        this.description,
        this.origin,
        this.originPageId,
        this.originLogo,
        this.originLink,
        this.type,
        this.like,
        this.commentCount,
        this.share,
        this.view,
        this.film,
        this.image,
        this.bookmark,
        this.comment,
        this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    origin = json['origin'];
    originPageId = json['originPageId'];
    originLogo = json['originLogo'];
    originLink = json['originLink'];
    type = json['type'];
    like = json['like'];
    commentCount = json['comment_count'];
    share = json['share'];
    view = json['view'];
    film = json['film'];
    image = json['image'];
    bookmark = json['bookmark'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['origin'] = this.origin;
    data['originPageId'] = this.originPageId;
    data['originLogo'] = this.originLogo;
    data['originLink'] = this.originLink;
    data['type'] = this.type;
    data['like'] = this.like;
    data['comment_count'] = this.commentCount;
    data['share'] = this.share;
    data['view'] = this.view;
    data['film'] = this.film;
    data['image'] = this.image;
    data['bookmark'] = this.bookmark;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? id;
  String? content;
  String? user;
  int? confess;
  String? avatar;
  String? createdAt;
  List<Null>? reply;

  Comment(
      {this.id,
        this.content,
        this.user,
        this.confess,
        this.avatar,
        this.createdAt,
        this.reply});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'];
    confess = json['confess'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    // if (json['reply'] != null) {
    //   reply = <Null>[];
    //   json['reply'].forEach((v) {
    //     reply!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['user'] = this.user;
    data['confess'] = this.confess;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    // if (this.reply != null) {
    //   data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
