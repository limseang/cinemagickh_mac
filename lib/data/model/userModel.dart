class UserModel {
  int? code;
  String? status;
  Data? data;

  UserModel({this.code, this.status, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? avatar;
  String? phone;
  String? emailVerifiedAt;
  int? roleId;
  String? password;
  String? point;
  String? userType;
  String? userUUID;
  String? token;
  String? comeFrom;
  String? fcmToken;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.avatar,
        this.phone,
        this.emailVerifiedAt,
        this.roleId,
        this.password,
        this.point,
        this.userType,
        this.userUUID,
        this.token,
        this.comeFrom,
        this.fcmToken,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    password = json['password'];
    point = json['point'];
    userType = json['user_type'];
    userUUID = json['userUUID'];
    token = json['token'];
    comeFrom = json['comeFrom'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['password'] = this.password;
    data['point'] = this.point;
    data['user_type'] = this.userType;
    data['userUUID'] = this.userUUID;
    data['token'] = this.token;
    data['comeFrom'] = this.comeFrom;
    data['fcm_token'] = this.fcmToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
