class VideoInfo {
  final String courseType;
  final String thumbnail;
  final String time;
  final String title;
  final String videoUrl;

  VideoInfo({
    required this.courseType,
    required this.thumbnail,
    required this.time,
    required this.title,
    required this.videoUrl,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      courseType: json['Coursetype'],
      thumbnail: json['thumbnail'],
      time: json['time'],
      title: json['title'],
      videoUrl: json['videoUrl'],
    );
  }
}
