import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';

import '../constants/app_constants.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // void getPhotos() async {
  //   var photosSnapshot = await _firestore
  //       .collection("users")
  //       .orderBy('uploadDate', descending: true)
  //       .get();
  //   List<String> firebasePhotos = []; // Yeni fotoğraf listesi
  //   for (var photo in photosSnapshot.docs) {
  //     firebasePhotos.add(photo.data()['photoUrl']);
  //   }
  //   setState(() {
  //     Sabitler.FirebasePhotos = firebasePhotos; // Fotoğraf listesini güncelle
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getPhotos();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.black,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            pinned: false, // SliverAppBar'ın kaybolmasını sağlar
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            title: Container(
              height: 45.h,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(15.r)),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Ara",
                  hintStyle: TextStyle(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 3.h, // Ana eksen boyunca öğeler arası boşluk
              crossAxisSpacing: 3.w, // Çapraz eksen boyunca öğeler arası boşluk
              childAspectRatio: 1.0, // Öğelerin en-boy oranı
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/discover', arguments: index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          Sabitler.FirebasePhotos[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount:
                  Sabitler.FirebasePhotos.length, // GridView'deki öğe sayısı
            ),
          ),
        ],
      ),
    );
  }
}
