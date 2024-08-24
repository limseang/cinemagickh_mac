
class ComingSoonFilmModel {
  int? id;
  String? title;
  String? releaseDateFormat;
  String? releaseDate;
  String? rating;
  int? ratePeople;
  String? poster;
  String? type;
  List<Null>? category;
  List<Null>? cast;

  ComingSoonFilmModel({this.id,
    this.title,
    this.releaseDateFormat,
    this.releaseDate,
    this.rating,
    this.ratePeople,
    this.poster,
    this.type,
    this.category,
    this.cast});

  ComingSoonFilmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    releaseDateFormat = json['release_date_format'];
    releaseDate = json['release_date'];
    rating = json['rating'];
    poster = json['poster'];
    ratePeople = json['rate_people'];
    type = json['type'];
    // if (json['category'] != null) {
    //   category = <Null>[];
    //   json['category'].forEach((v) {
    //     category!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['cast'] != null) {
    //   cast = <Null>[];
    //   json['cast'].forEach((v) {
    //     cast!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['release_date_format'] = this.releaseDateFormat;
    data['release_date'] = this.releaseDate;
    data['rating'] = this.rating;
    data['poster'] = this.poster;
    data['rate_people'] = this.ratePeople;
    data['type'] = this.type;
    // if (this.category != null) {
    //   data['category'] = this.category!.map((v) => v.toJson()).toList();
    // }
    // if (this.cast != null) {
    //   data['cast'] = this.cast!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}



// class Key {
//   int? id;
//   String? title;
//   String? releaseDateFormat;
//   String? releaseDate;
//   String? rating;
//   int? ratePeople;
//   String? type;
//   List<Null>? category;
//   List<Null>? cast;
//
//   Key(
//       {this.id,
//         this.title,
//         this.releaseDateFormat,
//         this.releaseDate,
//         this.rating,
//         this.ratePeople,
//         this.type,
//         this.category,
//         this.cast});
//
//   Key.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     releaseDateFormat = json['release_date_format'];
//     releaseDate = json['release_date'];
//     rating = json['rating'];
//     ratePeople = json['rate_people'];
//     type = json['type'];
//     // if (json['category'] != null) {
//     //   category = <Null>[];
//     //   json['category'].forEach((v) {
//     //     category!.add(new Null.fromJson(v));
//     //   });
//     // }
//     // if (json['cast'] != null) {
//     //   cast = <Null>[];
//     //   json['cast'].forEach((v) {
//     //     cast!.add(new Null.fromJson(v));
//     //   });
//     // }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['release_date_format'] = this.releaseDateFormat;
//     data['release_date'] = this.releaseDate;
//     data['rating'] = this.rating;
//     data['rate_people'] = this.ratePeople;
//     data['type'] = this.type;
//     // if (this.category != null) {
//     //   data['category'] = this.category!.map((v) => v.toJson()).toList();
//     // }
//     // if (this.cast != null) {
//     //   data['cast'] = this.cast!.map((v) => v.toJson()).toList();
//     // }
//     return data;
//   }
// }
