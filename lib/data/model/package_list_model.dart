class PackageListModel {
  int? code;
  String? message;
  Data? data;

  PackageListModel({this.code, this.message, this.data});

  PackageListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  List<Lists>? lists;

  Data({this.currentPage, this.lastPage, this.perPage, this.total, this.lists});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    if (json['lists'] != null) {
      lists = <Lists>[];
      json['lists'].forEach((v) {
        lists!.add(new Lists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    if (this.lists != null) {
      data['lists'] = this.lists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lists {
  int? id;
  String? uuid;
  String? name;
  String? price;
  String? currencySymbol;
  String? supplierName;
  String? createdAt;

  Lists(
      {this.id,
        this.uuid,
        this.name,
        this.price,
        this.currencySymbol,
        this.supplierName,
        this.createdAt});

  Lists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    price = json['price'];
    currencySymbol = json['currency_symbol'];
    supplierName = json['supplier_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['price'] = this.price;
    data['currency_symbol'] = this.currencySymbol;
    data['supplier_name'] = this.supplierName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
