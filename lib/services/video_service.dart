import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../models/video_model.dart';

class VideoService extends GetxService {
  static const String _apiKey =
      '5AejGBQIXCdIkEngoqsEBWfjvEOnv7JCtiVeNCw5AoM4KruOElEMAl5T'; // Pexels API key
  static const String _baseUrl = 'https://api.pexels.com/videos';
  static const int _perPage = 50;

  final List<String> _searchQueries = [
    'nature',
    'city',
    'ocean',
    'mountain',
    'forest',
    'sunset',
    'technology',
    'sports',
    'food',
    'travel',
    'wildlife',
    'space',
    'architecture',
    'music',
    'art',
  ];

  int _currentQueryIndex = 0;

  Future<List<VideoModel>> fetchVideos({required int page}) async {
    try {
      final query = _searchQueries[_currentQueryIndex % _searchQueries.length];

      final response = await http.get(
        Uri.parse(
          '$_baseUrl/search?query=$query&per_page=$_perPage&page=$page',
        ),
        headers: {'Authorization': _apiKey, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final videos =
            (data['videos'] as List)
                .map((video) => VideoModel.fromJson(video))
                .toList();

        // Rotate to next query for variety
        if (page % 5 == 0) {
          _currentQueryIndex++;
        }

        return videos;
      } else {
        throw Exception('Failed to load videos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching videos: $e');
      return [];
    }
  }

  Future<List<VideoModel>> fetchPopularVideos({required int page}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/popular?per_page=$_perPage&page=$page'),
        headers: {'Authorization': _apiKey, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['videos'] as List)
            .map((video) => VideoModel.fromJson(video))
            .toList();
      } else {
        throw Exception(
          'Failed to load popular videos: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching popular videos: $e');
      return [];
    }
  }
}
