import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';

class ThumbnailService {
  static final Map<String, String> _cache = {};

  static Future<String?> generateThumbnail(String videoUrl) async {
    try {
      final cacheKey = md5.convert(utf8.encode(videoUrl)).toString();
      
      if (_cache.containsKey(cacheKey)) {
        return _cache[cacheKey];
      }

      final random = Random();
      final timeMs = random.nextInt(10000); // Random frame within first 10 seconds

      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 300,
        maxWidth: 400,
        timeMs: timeMs,
        quality: 85,
      );

      if (thumbnailPath != null) {
        _cache[cacheKey] = thumbnailPath;
        return thumbnailPath;
      }
    } catch (e) {
      print('Error generating thumbnail: $e');
    }
    return null;
  }

  static void clearCache() {
    _cache.clear();
  }
}