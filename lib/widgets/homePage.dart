import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import '../constants/bottom_navigator.dart';
import '../constants/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            backgroundColor: Colors.black,
            elevation: 0,
            floating: true,
            title: Text(
              "Instagram",
              style: GoogleFonts.dancingScript(
                fontSize: 26.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.messenger_outline),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120.h,
              width: 412.w,
              color: Colors.black,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  mainStoryView(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return storyView();
                    },
                    itemCount: 30,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostWidgetConstant.PostView(index);
              },
              childCount: 10,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget mainStoryView() {
    return Container(
      margin: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 40.h,
                maxRadius: 40.h,
                backgroundImage: AssetImage('assets/images/vesikalik.png'),
              ),
              CircleAvatar(
                maxRadius: 10.h,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 15.h,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            "talhacosar29",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget storyView() {
    return Container(
      margin: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                minRadius: 40.h,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          const Text(
            "talhacosar29",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
