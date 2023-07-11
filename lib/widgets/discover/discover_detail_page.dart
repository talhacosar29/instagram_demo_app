import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/app_constants.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';
import 'package:instagram_demo_app/constants/post_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DiscoverDetailPage extends StatelessWidget {
  final int initialIndex;
  const DiscoverDetailPage({Key? key, required this.initialIndex})
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
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            snap: true,
            floating: true,
            pinned: false,
            title: Text(
              "Keşfet",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 685.h,
              width: double.infinity.w,
              color: Colors.black,
              child: ScrollablePositionedList.builder(
                itemCount: Sabitler.FirebasePhotos.length,
                itemBuilder: (context, index) {
                  return PostWidgetConstant.PostView(index, Sabitler.FirebasePhotos[index], Sabitler.FirebaseUsernames[index], Sabitler.FirebasePhotoLikes);
                },
                itemScrollController: _scrollController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
