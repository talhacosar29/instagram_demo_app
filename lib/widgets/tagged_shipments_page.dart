import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../constants/app_constants.dart';
import '../constants/post_widget.dart';

class TagedShipmentsPage extends StatelessWidget {
  final int initialIndex;

  const TagedShipmentsPage({Key? key, required this.initialIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ItemScrollController _scrollController = ItemScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.scrollTo(
          index: initialIndex, duration: Duration(milliseconds: 500));
    });
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Yönet",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.blue,
              ),
            ),
          )
        ],
        title: Text(
          "Etiketlendiklerin",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ScrollablePositionedList.builder(
        itemCount: Sabitler.FirebasePhotos.length,
        itemBuilder: (context, index) {
          return PostWidgetConstant.PostView(index);
        },
        itemScrollController: _scrollController,
      ),
    );
  }
}
