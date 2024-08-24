class UnifiedModel {
  final String type; // 'film' or 'article'
  final dynamic data; // FilmModel or ArticalModel

  UnifiedModel({required this.type, required this.data});
}