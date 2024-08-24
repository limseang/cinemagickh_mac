class GiftModel {
  bool? status;
  String? message;
  List<Data>? data;

  GiftModel({this.status, this.message, this.data});

  GiftModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? image;
  String? code;
  String? noted;
  String? point;
  String? quantity;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? expiredDate;

  Data(
      {this.id,
        this.name,
        this.description,
        this.image,
        this.code,
        this.noted,
        this.point,
        this.quantity,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.expiredDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    code = json['code'];
    noted = json['noted'];
    point = json['point'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    expiredDate = json['expired_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['code'] = this.code;
    data['noted'] = this.noted;
    data['point'] = this.point;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['expired_date'] = this.expiredDate;
    return data;
  }
}
