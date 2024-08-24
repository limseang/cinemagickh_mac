class DownloadVideoModel {
  final int videoId;
  final int episodeNumber;
  final int filmID;
  final String videoTitle;
  final String videoType;
  final int videoTime;
  final String videoUrl;
  final String image;

  DownloadVideoModel({
    required this.videoId,
    required this.episodeNumber,
    required this.filmID,
    required this.videoTitle,
    required this.videoType,
    required this.videoTime,
    required this.videoUrl,
    required this.image,
  });

  factory DownloadVideoModel.fromJson(Map<String, dynamic> json) {
    return DownloadVideoModel(
      videoId: json['videoId'],
      episodeNumber: json['episodeNumber'],
      filmID: json['filmID'],
      videoTitle: json['videoTitle'],
      videoType: json['videoType'],
      videoTime: json['videoTime'],
      videoUrl: json['videoUrl'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'episodeNumber': episodeNumber,
      'filmID': filmID,
      'videoTitle': videoTitle,
      'videoType': videoType,
      'videoTime': videoTime,
      'videoUrl': videoUrl,
      'image': image,
    };
  }
}