
class MissModel {
  final String? name;
  final String? country;
  final int? age;
  final String? photo;
  final List<String> photos;

  MissModel({
    this.name,
    this.country,
    this.age,
    this.photo,
    this.photos = const [],
  });
}