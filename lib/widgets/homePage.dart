import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';
import '../constants/bottom_navigator.dart';
import '../constants/post_widget.dart';
import 'login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  void getPhotos() async {
    var currentUser = "";
    List<String> firestorUserNames = []; // Kullanıcı adları
    var usersSnapshot = await _firestore.collection("users").get();
    for (var userFirestore in usersSnapshot.docs) {
      firestorUserNames.add(userFirestore.data()['user_name']);
      if (user?.uid == userFirestore.data()['user_id']) {
        currentUser = userFirestore.data()['user_name'];
      }
    }
    var photosSnapshot = await _firestore
        .collection("posts")
        .orderBy('uploadDate', descending: true)
        .get();
    List<String> firebasePhotos = []; // Yeni fotoğraf listesi
    List<int> photoLikes = []; // Fotoğrafın beğeni Sayısı
    List<String> userNames = []; // Kullanıcı adları
    int userLength = 0;
    for (var photo in photosSnapshot.docs) {
      firebasePhotos.add(photo.data()['photoUrl']);
      photoLikes.add(photo.data()['likes']);
      userNames.add(photo.data()['userName']);
    }

    firestorUserNames.remove(currentUser);
    userLength = firestorUserNames.length;
    setState(() {
      Sabitler.FirebasePhotos = firebasePhotos;
      Sabitler.FirebaseUsernames = userNames;
      Sabitler.FirebasePhotoLikes = photoLikes;
      Sabitler.FirebaseUserNamesList = firestorUserNames;
      Sabitler.userLength = userLength;
      Sabitler.currentUser = currentUser;
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
            titleSpacing: 20.w,
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
                icon: const Icon(Icons.favorite_border_outlined),
              ),
              SizedBox(
                width: 5.w,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ),
              SizedBox(
                width: 10.w,
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
                  SizedBox(width: 5.w),
                  mainStoryView(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return storyView(index);
                    },
                    itemCount: Sabitler
                        .userLength, //Sabitler.FirebaseUsernames.length,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostWidgetConstant.PostView(
                    index,
                    Sabitler.FirebasePhotos[index],
                    Sabitler.FirebaseUsernames[index],
                    Sabitler.FirebasePhotoLikes[index]);
              },
              childCount: Sabitler.FirebasePhotos.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigator(),
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
            Sabitler.currentUser,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget storyView(int index) {
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
          Text(
            Sabitler.FirebaseUserNamesList[index],
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
