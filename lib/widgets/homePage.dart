import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import '../constants/bottom_navigator.dart';

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
                return PostView(index);
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

  Widget PostView(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0), // Gölgenin konumu
            blurRadius: 5.h, // Gölge bulanıklığı
            spreadRadius: 1.w, // Gölgenin yayılma miktarı
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      height: 570.h,
      width: double.infinity.w,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 50.h,
            width: double.infinity.w,
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/vesikalik.png'),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "talhacosar29",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 165.w,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 410.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Sabitler.ProfilResimler[index]))),
          ),
          Container(
            height: 50.h,
            width: double.infinity.w,
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.mode_comment_outlined,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 190.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_sharp,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "5.050 beğenme",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "talhacosar29",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    "gkofgksdfpgjdfjpk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
