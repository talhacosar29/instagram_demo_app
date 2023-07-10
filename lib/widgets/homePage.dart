import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import '../constants/bottom_navigator.dart';
import '../constants/post_widget.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  void getPhotos() async {
    var photosSnapshot = await _firestore
        .collection("users")
        .orderBy('uploadDate', descending: true)
        .get();
    List<String> firebasePhotos = []; // Yeni fotoğraf listesi
    for (var photo in photosSnapshot.docs) {
      firebasePhotos.add(photo.data()['photoUrl']);
    }
    setState(() {
      Sabitler.FirebasePhotos = firebasePhotos; // Fotoğraf listesini güncelle
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

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
              Center(
                child: Text(
                  "Çıkış Yap",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120.h,
              width: 750.w,
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
              childCount: Sabitler.FirebasePhotos.length,
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
