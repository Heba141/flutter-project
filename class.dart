class Course {
  final String courseType;
  final String thumbnail;
  final String time;
  final String title;
  final String videoUrl;
  final String uploaderPhoto;
  Course({
    required this.courseType,
    required this.thumbnail,
    required this.time,
    required this.title,
    required this.videoUrl,
    required this.uploaderPhoto,

  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseType: map['Coursetype'],
      thumbnail: map['thumbnail'],
      time: map['time'],
      title: map['title'],
      videoUrl: map['videoUrl'],
      uploaderPhoto: map['uploaderPhoto'],

    );
  }
}
