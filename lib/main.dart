import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/video_controller.dart';
import 'services/video_service.dart';
import 'views/video_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Video Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoListView(),
      initialBinding: BindingsBuilder(() {
        Get.put(VideoService());
        Get.put(VideoController());
      }),
    );
  }
}
