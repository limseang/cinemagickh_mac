class MovieDetailModel {
  int? code;
  String? status;
  Data? data;

  MovieDetailModel({this.code, this.status, this.data});

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? overview;
  String? releaseDate;
  Category? category;
  Category? categoryIds;
  String? tag;
  String? tagId;
  String? distributors;
  String? distributorId;
  String? poster;
  String? trailer;
  int? view;
  String? type;
  String? typeId;
  String? runningTime;
  String? language;
  String? languageId;
  String? rating;
  int? ratePeople;
  List<Available>? available;
  List<Cast>? cast;
  List<Episode>? episode;
  String? cover;
  Genre? genre;
  int? genreId;
  List<Comment>? comment;

  Data(
      {this.id,
        this.title,
        this.overview,
        this.releaseDate,
        this.category,
        this.categoryIds,
        this.tag,
        this.tagId,
        this.distributors,
        this.distributorId,
        this.poster,
        this.trailer,
        this.view,
        this.type,
        this.typeId,
        this.runningTime,
        this.language,
        this.languageId,
        this.rating,
        this.ratePeople,
        this.available,
        this.cast,
        this.episode,
        this.cover,
        this.genre,
        this.genreId,
        this.comment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    categoryIds = json['category_ids'] != null
        ? new Category.fromJson(json['category_ids'])
        : null;
    tag = json['tag'];
    tagId = json['tag_id'];
    distributors = json['distributors'];
    distributorId = json['distributor_id'];
    poster = json['poster'];
    trailer = json['trailer'];
    view = json['view'];
    type = json['type'];
    typeId = json['type_id'];
    runningTime = json['running_time'];
    language = json['language'];
    languageId = json['language_id'];
    rating = json['rating'];
    ratePeople = json['rate_people'];
    if (json['available'] != null) {
      available = <Available>[];
      json['available'].forEach((v) {
        available!.add(new Available.fromJson(v));
      });
    }
    if (json['cast'] != null) {
      cast = <Cast>[];
      json['cast'].forEach((v) {
        cast!.add(new Cast.fromJson(v));
      });
    }
    if (json['episode'] != null) {
      episode = <Episode>[];
      json['episode'].forEach((v) {
        episode!.add(new Episode.fromJson(v));
      });
    }
    cover = json['cover'];
    genre = json['genre'] != null ? new Genre.fromJson(json['genre']) : null;
    genreId = json['genre_id'];
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
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.categoryIds != null) {
      data['category_ids'] = this.categoryIds!.toJson();
    }
    data['tag'] = this.tag;
    data['tag_id'] = this.tagId;
    data['distributors'] = this.distributors;
    data['distributor_id'] = this.distributorId;
    data['poster'] = this.poster;
    data['trailer'] = this.trailer;
    data['view'] = this.view;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['running_time'] = this.runningTime;
    data['language'] = this.language;
    data['language_id'] = this.languageId;
    data['rating'] = this.rating;
    data['rate_people'] = this.ratePeople;
    if (this.available != null) {
      data['available'] = this.available!.map((v) => v.toJson()).toList();
    }
    if (this.cast != null) {
      data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    }
    if (this.episode != null) {
      data['episode'] = this.episode!.map((v) => v.toJson()).toList();
    }
    data['cover'] = this.cover;
    if (this.genre != null) {
      data['genre'] = this.genre!.toJson();
    }
    data['genre_id'] = this.genreId;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  Null? createdAt;
  Null? updatedAt;
  String? name;
  String? description;
  Null? image;
  String? status;

  Category(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
        this.image,
        this.status});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class Available {
  int? id;
  String? available;
  String? url;
  String? logo;

  Available({this.id, this.available, this.url, this.logo});

  Available.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    available = json['available'];
    url = json['url'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['available'] = this.available;
    data['url'] = this.url;
    data['logo'] = this.logo;
    return data;
  }
}

class Cast {
  String? id;
  String? name;
  String? position;
  String? character;
  String? image;

  Cast({this.id, this.name, this.position, this.character, this.image});

  Cast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    position = json['position'];
    character = json['character'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['position'] = this.position;
    data['character'] = this.character;
    data['image'] = this.image;
    return data;
  }
}

class Episode {
  int? id;
  String? title;
  String? description;
  String? episode;
  String? season;
  String? releaseDate;
  String? file;
  String? poster;

  Episode(
      {this.id,
        this.title,
        this.description,
        this.episode,
        this.season,
        this.releaseDate,
        this.file,
        this.poster});

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    episode = json['episode'];
    season = json['season'];
    releaseDate = json['release_date'];
    file = json['file'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['episode'] = this.episode;
    data['season'] = this.season;
    data['release_date'] = this.releaseDate;
    data['file'] = this.file;
    data['poster'] = this.poster;
    return data;
  }
}

class Genre {
  int? id;
  String? name;
  String? description;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Genre(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Comment {
  int? id;
  String? comment;
  String? userId;
  String? user;
  String? rate;
  String? avatar;
  String? createdAt;
  List<Null>? reply;
  int? confess;

  Comment(
      {this.id,
        this.comment,
        this.userId,
        this.user,
        this.rate,
        this.avatar,
        this.createdAt,
        this.reply,
        this.confess});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    userId = json['user_id'];
    user = json['user'];
    rate = json['rate'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    // if (json['reply'] != null) {
    //   reply = <Null>[];
    //   json['reply'].forEach((v) {
    //     reply!.add(new Null.fromJson(v));
    //   });
    // }
    confess = json['confess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['user'] = this.user;
    data['rate'] = this.rate;
    data['avatar'] = this.avatar;
    data['created_at'] = this.createdAt;
    // if (this.reply != null) {
    //   data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    // }
    data['confess'] = this.confess;
    return data;
  }
}
