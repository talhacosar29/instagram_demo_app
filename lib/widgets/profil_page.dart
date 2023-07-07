import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/app_constants.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigator(),
        backgroundColor: Colors.black,
        appBar: AppBar(
          leadingWidth: 0,
          leading: Container(),
          backgroundColor: Colors.black,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_box_outlined)),
            IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          ],
          title: Row(
            children: [
              Text(
                "talhacosar29",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 15.w),
            ],
          ),
        ),
        body: ListView(
          children: [
            followerView(),
            biographyView(),
            profileButtonsView(),
            TabbarWidgetView(),
          ],
        ),
      ),
    );
  }

  Widget TabbarWidgetView() {
    return Expanded(
      child: Container(
        height: 550.h,
        padding: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            Container(
              height: 45.h,
              child: TabBar(
                indicatorWeight: 1.w,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.grid_on_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    child: Center(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3.h, // Ana eksen aralığı
                          crossAxisSpacing: 3.w, // Yatay eksen aralığı
                          childAspectRatio: 1, // Öğelerin en/boy oranı
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  Sabitler.ProfilResimler[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 3.h, // Ana eksen aralığı
                        crossAxisSpacing: 3.w, // Yatay eksen aralığı
                        childAspectRatio: 1, // Öğelerin en/boy oranı
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                Sabitler.ProfilResimler[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget followerView() {
    return Container(
      padding: EdgeInsets.only(top: 10.h, left: 20.w),
      height: 110.h,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 95.h,
            width: 95.w,
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/vesikalik.png"),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              height: 95.h,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "10",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          "Gönderi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "312",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          "Takipçi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "345",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 20.sp),
                        ),
                        Text(
                          "Takip",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget biographyView() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
      ),
      alignment: Alignment.centerLeft,
      height: 60.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Talha Coşar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "İstanbul / Kartal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "BEU / CE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget profileButtonsView() {
    return Container(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.grey.shade700,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(180.w, 35.h),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Profili Düzenle",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.grey.shade700,
              ),
              minimumSize: MaterialStateProperty.all<Size>(Size(180.w, 35.h)),
            ),
            onPressed: () {},
            child: Text(
              "Profili Paylaş",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
