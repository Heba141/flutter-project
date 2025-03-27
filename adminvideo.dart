class AdminVideo {
  final String username;
  final String profilePhotoUrl;
  final String videoTitle;
  final String videoLink;

  AdminVideo({
    required this.username,
    required this.profilePhotoUrl,
    required this.videoTitle,
    required this.videoLink,
  });

  // Convert an AdminVideo to a Map (for Firebase or local storage)
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profilePhotoUrl': profilePhotoUrl,
      'videoTitle': videoTitle,
      'videoLink': videoLink,
    };
  }

  // Convert a Map to an AdminVideo (for retrieving data from Firebase or local storage)
  factory AdminVideo.fromMap(Map<String, dynamic> map) {
    return AdminVideo(
      username: map['username'],
      profilePhotoUrl: map['profilePhotoUrl'],
      videoTitle: map['videoTitle'],
      videoLink: map['videoLink'],
    );
  }
}
