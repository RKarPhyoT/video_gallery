import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/video_controller.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.find<VideoController>();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              // color: Color(0xFFEDCE76),
              gradient: LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              border: Border(
                top: BorderSide(width: 2, color: Color(0xFFE4B764)),
                left: BorderSide(width: 2, color: Color(0xFFE4B764)),
                right: BorderSide(width: 2, color: Color(0xFFE4B764)),
              ),
            ),
            alignment: Alignment.center,
            child: Text("App Title"),
          ),
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          Container(
            height: 90,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFD6D6D8).withValues(alpha: 0.2),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => _scrollWidget(index, controller),
              separatorBuilder: (context, index) => SizedBox(width: 5),
              itemCount: 40,
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6E6E8),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "LIVE 20",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "6",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDCE76),
                      borderRadius: BorderRadius.circular(40),
                      border: Border(
                        top: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        left: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        right: BorderSide(width: 2, color: Color(0xFFE4B764)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "CHAI DAU",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: FlutterLogo(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDCE76),
                      borderRadius: BorderRadius.circular(40),
                      border: Border(
                        top: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        left: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        right: BorderSide(width: 2, color: Color(0xFFE4B764)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "THOD GIAN",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: FlutterLogo(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFCACBCC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollWidget(int index, VideoController controller) => Column(
    children: [
      Text(
        "T$index",
        style: TextStyle(
          color: Colors.black.withValues(alpha: 0.5),
          fontSize: 8,
        ),
      ),
      Obx(
        () => InkWell(
          onTap: () {
            controller.selectedIndex.value = index;
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  index == controller.selectedIndex.value
                      ? Color(0xFFEDCE76)
                      : Colors.white,

              border:
                  index == controller.selectedIndex.value
                      ? Border(
                        top: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        left: BorderSide(width: 2, color: Color(0xFFE4B764)),
                        right: BorderSide(width: 2, color: Color(0xFFE4B764)),
                      )
                      : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: Offset(-1, 1),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(index.toString(), style: TextStyle(fontSize: 12)),
                if (index == controller.selectedIndex.value)
                  Container(width: 10, height: 4, color: Colors.black),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
