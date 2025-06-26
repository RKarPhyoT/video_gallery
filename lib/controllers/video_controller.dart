import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../services/video_service.dart';
import '../services/thumbnail_service.dart';

class VideoController extends GetxController {
  final VideoService _videoService = Get.find<VideoService>();

  final RxList<VideoModel> videos = <VideoModel>[].obs;
  final RxMap<String, RxList<VideoModel>> groupVideos =
      <String, RxList<VideoModel>>{}.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxString errorMessage = ''.obs;
  RxInt selectedIndex = 0.obs;

  final ScrollController scrollController = ScrollController();

  int _currentPage = 1;
  static const int TOTAL_TARGET = 5000000; // 5 million target

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    loadInitialVideos();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 1000) {
      loadMoreVideos();
    }

    // Only preload if not refreshing and videos exist
    if (!isRefreshing.value && videos.isNotEmpty) {
      _preloadVisibleThumbnails();
    }
  }

  Future<void> loadInitialVideos() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final newVideos = await _videoService.fetchPopularVideos(page: 1);
      videos.assignAll(newVideos);
      _groupVideos();
      _currentPage = 2;

      // Start preloading thumbnails
      _preloadVisibleThumbnails();
    } catch (e) {
      errorMessage.value = 'Failed to load videos: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreVideos() async {
    if (isLoadingMore.value || videos.length >= TOTAL_TARGET) return;

    try {
      isLoadingMore.value = true;

      final newVideos = await _videoService.fetchVideos(page: _currentPage);

      if (newVideos.isNotEmpty) {
        videos.addAll(newVideos);
        _groupVideos();
        _currentPage++;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load more videos: $e';
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshVideos() async {
    try {
      isRefreshing.value = true;
      errorMessage.value = '';

      // Stop any ongoing operations
      videos.clear(); // Clear immediately to prevent index errors
      _currentPage = 1;

      // Clear caches
      ThumbnailService.clearCache();

      // Reset scroll position
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
      }

      final newVideos = await _videoService.fetchPopularVideos(page: 1);
      videos.assignAll(newVideos);
      _groupVideos();
      _currentPage = 2;

      // Small delay before preloading to ensure UI is updated
      await Future.delayed(Duration(milliseconds: 100));
      _preloadVisibleThumbnails();
    } catch (e) {
      errorMessage.value = 'Failed to refresh videos: $e';
    } finally {
      isRefreshing.value = false;
    }
  }

  void _preloadVisibleThumbnails() {
    if (scrollController.hasClients && videos.isNotEmpty) {
      final firstVisibleIndex = (scrollController.offset / 180).floor().clamp(
        0,
        videos.length - 1,
      );
      final lastVisibleIndex = (firstVisibleIndex + 12).clamp(
        0,
        videos.length - 1,
      );

      for (
        int i = firstVisibleIndex;
        i <= lastVisibleIndex && i < videos.length;
        i++
      ) {
        if (i >= 0 &&
            i < videos.length &&
            videos[i].localThumbnailPath == null &&
            !videos[i].isLoadingThumbnail) {
          _generateThumbnailForVideo(i);
        }
      }
    }
  }

  Future<void> _generateThumbnailForVideo(int index) async {
    if (index < 0 || index >= videos.length) return;

    final video = videos[index];
    if (video.isLoadingThumbnail) return; // Prevent duplicate requests

    // Safely update the video state
    videos[index] = video.copyWith(isLoadingThumbnail: true);

    try {
      final thumbnailPath = await ThumbnailService.generateThumbnail(
        video.videoUrl,
      );

      // Check if index is still valid after async operation
      if (index < videos.length && videos[index].id == video.id) {
        if (thumbnailPath != null) {
          videos[index] = video.copyWith(
            localThumbnailPath: thumbnailPath,
            isLoadingThumbnail: false,
          );
        } else {
          videos[index] = video.copyWith(isLoadingThumbnail: false);
        }
      }
    } catch (e) {
      // Check if index is still valid after async operation
      if (index < videos.length && videos[index].id == video.id) {
        videos[index] = video.copyWith(isLoadingThumbnail: false);
      }
      print('Error generating thumbnail for video ${video.id}: $e');
    }
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    } else {
      return views.toString();
    }
  }

  void _groupVideos() {
    final grouped = <String, RxList<VideoModel>>{};
    for (int i = 0; i < videos.length; i += 3) {
      final groupIndex = (i ~/ 3).toString();
      final group = videos.sublist(
        i,
        i + 3 > videos.length ? videos.length : i + 3,
      );
      grouped[groupIndex] = RxList<VideoModel>.from(group);
    }
    groupVideos.assignAll(grouped);
  }
}
