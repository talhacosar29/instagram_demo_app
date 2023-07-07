import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/app_constants.dart';

import '../widgets/profil_page.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (value) {
        if (value == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }

        if (value == 4) {
          if (Sabitler.page_num != value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilPage(),
                ));
          }
        }
        Sabitler.page_num = value;
        debugPrint(value.toString());
      },
      iconSize: 32.w,
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            color: Colors.white,
          ),
          label: '',
        ),
      ],
    );
  }
}
