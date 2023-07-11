import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/app_constants.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';

import '../../constants/post_widget.dart';

class ShipmentsPage extends StatelessWidget {
  final int initialIndex;

  const ShipmentsPage({Key? key, required this.initialIndex}) : super(key: key);

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
        title: Text(
          "Gönderiler",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ScrollablePositionedList.builder(
        itemCount: Sabitler.currentFirebasePhotos.length,
        itemBuilder: (context, index) {
          return PostWidgetConstant.PostView(index, Sabitler.currentFirebasePhotos[index]);
        },
        itemScrollController: _scrollController,
      ),
    );
  }
}
