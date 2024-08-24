

class MissInfoModel {
  int? id;
  String? missGrandNo;
  String? name;
  String? nickname;
  String? description;
  String? picProfileUrl;
  // Map<String,dynamic>? picCoverUrl;
  int? countryId;
  String? countryName;
  int? missGrandTypeId;
  String? missGrandTypeName;
  String? totalVote;
  List<String>? missGrandGallery;
  bool? comments;
  String? createdAt;

  MissInfoModel(
      {
        this.id,
        this.missGrandNo,
        this.name,
        this.nickname,
        this.description,
        this.picProfileUrl,
        // this.picCoverUrl,
        this.countryId,
        this.countryName,
        this.missGrandTypeId,
        this.missGrandTypeName,
        this.totalVote,
        this.comments,
        this.missGrandGallery,
        this.createdAt});

  MissInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    missGrandNo = json['miss_grand_no'];
    name = json['name'];
    nickname = json['nickname'];
    description = json['description'];
    picProfileUrl = json['pic_profile_url'].toString();
    // picCoverUrl = json['pic_cover_url'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    missGrandTypeId = json['miss_grand_type_id'];
    missGrandTypeName = json['miss_grand_type_name'];
    totalVote = json['total_vote'];
    createdAt = json['created_at'];
    if (json['miss_grand_gallery'] != null) {
      missGrandGallery = <String>[];
      json['miss_grand_gallery'].forEach((v) {
        missGrandGallery!.add(v);
      });
    }
    comments = json['comments'];
    // if (json['comments'] != null) {
    //   comments = <Comments>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(new Comments.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['miss_grand_no'] = this.missGrandNo;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['description'] = this.description;
    data['pic_profile_url'] = this.picProfileUrl;
    // data['pic_cover_url'] = this.picCoverUrl;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['miss_grand_type_id'] = this.missGrandTypeId;
    data['miss_grand_type_name'] = this.missGrandTypeName;
    data['total_vote'] = this.totalVote;
    data['created_at'] = this.createdAt;
    data['comments'] = this.comments;
    return data;
  }
}


class Comments {
  String? comment;
  int? userId;
  String? userName;
  String? userProfilePicture;
  String? createdAt;

  Comments(
      {this.comment,
      this.userId,
      this.userName,
      this.userProfilePicture,
      this.createdAt});

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    userId = json['user_id'];
    userName = json['user_name'];
    userProfilePicture = json['user_profile_picture'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_profile_picture'] = this.userProfilePicture;
    data['created_at'] = this.createdAt;
    return data;
  }
}