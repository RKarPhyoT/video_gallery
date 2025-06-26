import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/video_controller.dart';
import '../widges/title_widget.dart';
import '../widges/video_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final VideoController controller = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE8E9EB),
        body: Column(
          children: [
            TitleWidget(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.groupVideos.isEmpty) {
                  return _buildLoadingIndicator();
                }

                if (controller.errorMessage.value.isNotEmpty &&
                    controller.groupVideos.isEmpty) {
                  return _buildErrorWidget(controller);
                }
                if (!controller.isLoading.value &&
                    controller.groupVideos.isEmpty) {
                  return _retryWidget(controller);
                }
                return RefreshIndicator(
                  onRefresh: controller.refreshVideos,
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(1.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            groupIndex,
                          ) {
                            final groupKey = groupIndex.toString();
                            final group =
                                controller.groupVideos[groupKey] ?? [];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Group ${groupIndex + 1}', // 👈 Dynamic title
                                  //   style: const TextStyle(
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20),
                                        FlutterLogo(),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                height: 50,
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEDCE76),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(40),
                                                        topLeft:
                                                            Radius.circular(40),
                                                      ),
                                                ),
                                                child: Text(
                                                  "Marble Magic P8",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 10,
                                                child: Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                          topRight:
                                                              Radius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                    5,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      "HOM NAY THANG 12",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  ...group.map(
                                    (video) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 0.0,
                                      ),
                                      child: VideoCard(video: video),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }, childCount: controller.groupVideos.length),
                        ),
                      ),
                      if (controller.isLoadingMore.value)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
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
}
