import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import '../models/video_model.dart';
import '../controllers/video_controller.dart';

class VideoCard extends StatelessWidget {
  final VideoModel video;
  const VideoCard({super.key, required this.video});
  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.find<VideoController>();

    return SizedBox(
      height: 50,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 70,
                  height: 40,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFEBECEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text("01:00\n13/09"),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "LIVE",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 4,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SizedBox(width: double.infinity, child: _buildThumbnail()),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(video.title, style: TextStyle(fontSize: 4)),
                          SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              controller.formatDuration(video.duration),
                              style: TextStyle(
                                fontSize: 4,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Expanded(
        //       child: ClipRRect(
        //         borderRadius: const BorderRadius.vertical(
        //           top: Radius.circular(12),
        //         ),
        //         child: Stack(
        //           children: [
        //             SizedBox(width: double.infinity, child: _buildThumbnail()),
        //             Positioned(
        //               bottom: 8,
        //               right: 8,
        //               child: Container(
        //                 padding: const EdgeInsets.symmetric(
        //                   horizontal: 6,
        //                   vertical: 2,
        //                 ),
        //                 decoration: BoxDecoration(
        //                   color: Colors.black87,
        //                   borderRadius: BorderRadius.circular(4),
        //                 ),
        //                 child: Text(
        //                   controller.formatDuration(video.duration),
        //                   style: const TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 10,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             video.title,
        //             style: const TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 12,
        //             ),
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           const SizedBox(height: 4),
        //           Row(
        //             children: [
        //               CircleAvatar(
        //                 radius: 8,
        //                 backgroundImage:
        //                     video.userImage.isNotEmpty
        //                         ? CachedNetworkImageProvider(video.userImage)
        //                         : null,
        //                 child:
        //                     video.userImage.isEmpty
        //                         ? const Icon(Icons.person, size: 12)
        //                         : null,
        //               ),
        //               const SizedBox(width: 4),
        //               Expanded(
        //                 child: Text(
        //                   video.userName,
        //                   style: TextStyle(
        //                     color: Colors.grey[600],
        //                     fontSize: 10,
        //                   ),
        //                   maxLines: 1,
        //                   overflow: TextOverflow.ellipsis,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           const SizedBox(height: 2),
        //           Text(
        //             '${controller.formatViews(video.views)} views',
        //             style: TextStyle(color: Colors.grey[600], fontSize: 10),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (video.isLoadingThumbnail) {
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
          ),
        ),
      );
    }
    if (video.localThumbnailPath != null) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.file(
          File(video.localThumbnailPath!),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackThumbnail();
          },
        ),
      );
    }

    return _buildFallbackThumbnail();
  }

  Widget _buildFallbackThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: video.thumbnailUrl,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Container(
              color: Colors.grey[300],
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
                ),
              ),
            ),
        errorWidget:
            (context, url, error) => Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.play_circle_outline,
                size: 40,
                color: Colors.grey[500],
              ),
            ),
      ),
    );
  }
}
