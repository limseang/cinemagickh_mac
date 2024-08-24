class NotificationModel {
  String? title;
  String? body;
  String? chatUuid;
  String? sound;
  String? image;
  String? name;
  String? type;
  String? id;
  String? channelKey;
  List<Data>? data ;

  NotificationModel(
      {this.title,
      this.body,
      this.sound,
      this.chatUuid,
      this.image,
      this.channelKey,
        this.type,
        this.id,
      this.name,
      this.data
      });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    chatUuid = json['chat_uuid'];
    sound = json['sound'];
    image = json['avatar_url'];
    name = json['title'];
    type = json['type'];
    id = json['id'];
    channelKey = json['channel_key'];
   if(json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['chat_uuid'] = this.chatUuid;
    data['sound'] = this.sound;
    data['avatar_url'] = this.image;
    data['title'] = this.name;
    data['type'] = this.type;
    data['id'] = this.id;
    data['channel_key'] = this.channelKey;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data{
  String? id;
  String? type;
  Data({this.id,this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ;
    data['type'] = this.type ;
    return data;
  }
}
