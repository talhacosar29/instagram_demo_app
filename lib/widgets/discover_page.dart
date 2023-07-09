import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/bottom_navigator.dart';
import 'package:instagram_demo_app/widgets/discover_detail_page.dart';

import '../constants/app_constants.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
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
              height: 45,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(15)),
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  icon: Icon(
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
              mainAxisSpacing: 3, // Ana eksen boyunca öğeler arası boşluk
              crossAxisSpacing: 3, // Çapraz eksen boyunca öğeler arası boşluk
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
                        image: AssetImage(
                          Sabitler.ProfilResimler[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: 10, // GridView'deki öğe sayısı
            ),
          ),
        ],
      ),
    );
  }
}
