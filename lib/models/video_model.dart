class VideoModel {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final int duration;
  final int views;
  final String userImage;
  final String userName;
  String? localThumbnailPath;
  bool isLoadingThumbnail;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.views,
    required this.userImage,
    required this.userName,
    this.localThumbnailPath,
    this.isLoadingThumbnail = false,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['user']['name'] ?? 'Unknown',
      description: json['tags']?.join(', ') ?? '',
      thumbnailUrl: json['image'],
      videoUrl: json['video_files'][0]['link'],
      duration: json['duration'],
      views: json['id'] * 1000, // Pexels doesn't provide views, so we simulate
      userImage: json['user']['avatar'] ?? '',
      userName: json['user']['name'] ?? 'Unknown User',
    );
  }

  VideoModel copyWith({String? localThumbnailPath, bool? isLoadingThumbnail}) {
    return VideoModel(
      id: this.id,
      title: this.title,
      description: this.description,
      thumbnailUrl: this.thumbnailUrl,
      videoUrl: this.videoUrl,
      duration: this.duration,
      views: this.views,
      userImage: this.userImage,
      userName: this.userName,
      localThumbnailPath: localThumbnailPath ?? this.localThumbnailPath,
      isLoadingThumbnail: isLoadingThumbnail ?? this.isLoadingThumbnail,
    );
  }
}
