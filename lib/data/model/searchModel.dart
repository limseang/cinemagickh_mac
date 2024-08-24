class SearchModel {
  String? message;
  Data? data;

  SearchModel({this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  List<Artical>? artical;
  List<Film>? film;
  List<Video>? video;

  Data({this.artical, this.film, this.video});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['artical'] != null) {
      artical = <Artical>[];
      json['artical'].forEach((v) {
        artical!.add(new Artical.fromJson(v));
      });
    }
    if (json['film'] != null) {
      film = <Film>[];
      json['film'].forEach((v) {
        film!.add(new Film.fromJson(v));
      });
    }
    if (json['video'] != null) {
      video = <Video>[];
      json['video'].forEach((v) {
        video!.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artical != null) {
      data['artical'] = this.artical!.map((v) => v.toJson()).toList();
    }
    if (this.film != null) {
      data['film'] = this.film!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artical {
  int? id;
  String? title;
  String? description;
  String? originId;
  String? categoryId;
  String? image;
  String? typeId;
  String? like;
  Null? comment;
  String? share;
  String? view;
  Null? film;
  Null? tag;
  String? status;
  String? createdAt;
  String? updatedAt;
  Origin? origin;
  Category? category;
  Type? type;
  List<CategoryArtical>? categoryArtical;

  Artical(
      {this.id,
        this.title,
        this.description,
        this.originId,
        this.categoryId,
        this.image,
        this.typeId,
        this.like,
        this.comment,
        this.share,
        this.view,
        this.film,
        this.tag,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.origin,
        this.category,
        this.type,
        this.categoryArtical});

  Artical.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    originId = json['origin_id'];
    categoryId = json['category_id'];
    image = json['image'];
    typeId = json['type_id'];
    like = json['like'];
    comment = json['comment'];
    share = json['share'];
    view = json['view'];
    film = json['film'];
    tag = json['tag'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    origin =
    json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    if (json['category_artical'] != null) {
      categoryArtical = <CategoryArtical>[];
      json['category_artical'].forEach((v) {
        categoryArtical!.add(new CategoryArtical.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['origin_id'] = this.originId;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['type_id'] = this.typeId;
    data['like'] = this.like;
    data['comment'] = this.comment;
    data['share'] = this.share;
    data['view'] = this.view;
    data['film'] = this.film;
    data['tag'] = this.tag;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.categoryArtical != null) {
      data['category_artical'] =
          this.categoryArtical!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Origin {
  int? id;
  String? name;
  String? description;
  String? logo;
  String? url;
  String? pageId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Origin(
      {this.id,
        this.name,
        this.description,
        this.logo,
        this.url,
        this.pageId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    url = json['url'];
    pageId = json['page_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['url'] = this.url;
    data['page_id'] = this.pageId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class Type {
  int? id;
  String? name;
  String? description;
  String? status;
  Null? createdAt;
  Null? updatedAt;

  Type(
      {this.id,
        this.name,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CategoryArtical {
  int? id;
  String? categoryId;
  String? articalId;
  String? createdAt;
  String? updatedAt;

  CategoryArtical(
      {this.id,
        this.categoryId,
        this.articalId,
        this.createdAt,
        this.updatedAt});

  CategoryArtical.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    articalId = json['artical_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['artical_id'] = this.articalId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Film {
  int? id;
  String? title;
  String? releaseDate;
  String? overview;
  String? poster;
  String? rating;
  String? type;
  List<Null>? category;
  String? createdAt;

  Film(
      {this.id,
        this.title,
        this.releaseDate,
        this.overview,
        this.poster,
        this.rating,
        this.type,
        this.category,
        this.createdAt});

  Film.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    releaseDate = json['release_date'];
    overview = json['overview'];
    poster = json['poster'];
    rating = json['rating'];
    type = json['type'];
    // if (json['category'] != null) {
    //   category = <Null>[];
    //   json['category'].forEach((v) {
    //     category!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['overview'] = this.overview;
    data['poster'] = this.poster;
    data['rating'] = this.rating;
    data['type'] = this.type;
    // if (this.category != null) {
    //   data['category'] = this.category!.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Video {
  int? id;
  String? title;
  String? description;
  String? coverImageUrl;
  int? status;
  String? categories;
  String? runningTime;
  String? tag;

  Video(
      {this.id,
        this.title,
        this.description,
        this.coverImageUrl,
        this.status,
        this.categories,
        this.runningTime,
        this.tag});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImageUrl = json['cover_image_url'];
    status = json['status'];
    categories = json['categories'];
    runningTime = json['running_time'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_image_url'] = this.coverImageUrl;
    data['status'] = this.status;
    data['categories'] = this.categories;
    data['running_time'] = this.runningTime;
    data['tag'] = this.tag;
    return data;
  }
}
