// class ArtistModel {
//   String? message;
//   List<Data>? data;
//
//   ArtistModel({this.message, this.data});
//
//   ArtistModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? nationality;
//   String? nationalityLogo;
//   String? profile;
//   String? status;
//
//   Data(
//       {this.id,
//         this.name,
//         this.nationality,
//         this.nationalityLogo,
//         this.profile,
//         this.status});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     nationality = json['nationality'];
//     nationalityLogo = json['nationality_logo'];
//     profile = json['profile'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['nationality'] = this.nationality;
//     data['nationality_logo'] = this.nationalityLogo;
//     data['profile'] = this.profile;
//     data['status'] = this.status;
//     return data;
//   }
// }
