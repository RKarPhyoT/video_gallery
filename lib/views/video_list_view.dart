import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/video_controller.dart';
import '../widges/video_card.dart';

class VideoListView extends StatelessWidget {
  const VideoListView({super.key});
  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.find<VideoController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Video Gallery (${controller.videos.length.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} videos)',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: Obx(() {
        if (controller.isLoading.value && controller.groupVideos.isEmpty) {
          return _buildLoadingIndicator();
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.groupVideos.isEmpty) {
          return _buildErrorWidget(controller);
        }
        if (!controller.isLoading.value && controller.groupVideos.isEmpty) {
          return _retryWidget(controller);
        }
        return RefreshIndicator(
          onRefresh: controller.refreshVideos,
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, groupIndex) {
                    final group =
                        controller.groupVideos[groupIndex.toString()] ?? [];
                    return Row(
                      children:
                          group
                              .map(
                                (video) =>
                                    Expanded(child: VideoCard(video: video)),
                              )
                              .toList(),
                    );
                  }, childCount: controller.groupVideos.length),
                ),
                //  SliverGrid(
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 8.0,
                //     mainAxisSpacing: 8.0,
                //     childAspectRatio: 0.75,
                //   ),
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       if (index >= controller.videos.length) {
                //         return _buildLoadingCard();
                //       }
                //       return VideoCard(video: controller.videos[index]);
                //     },
                //     childCount:
                //         controller.videos.length +
                //         (controller.isLoadingMore.value ? 10 : 0),
                //   ),
                // ),
              ),
              if (controller.isLoadingMore.value)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 3.0),
          SizedBox(height: 16),
          Text(
            'Loading videos...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _retryWidget(VideoController controller) {
    return Center(
      child: ElevatedButton(
        onPressed: controller.loadInitialVideos,
        child: const Text('Retry'),
      ),
    );
  }

  Widget _buildErrorWidget(VideoController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            controller.errorMessage.value,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.loadInitialVideos,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Widget _buildLoadingCard() {
  //   return Card(
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Expanded(
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.grey[300],
  //               borderRadius: const BorderRadius.vertical(
  //                 top: Radius.circular(12),
  //               ),
  //             ),
  //             child: Center(
  //               child: CircularProgressIndicator(
  //                 strokeWidth: 2.0,
  //                 valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(height: 12, color: Colors.grey[300]),
  //               const SizedBox(height: 4),
  //               Container(height: 10, width: 100, color: Colors.grey[300]),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
