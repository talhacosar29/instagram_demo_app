import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/widgets/discover/discover_detail_page.dart';
import 'package:instagram_demo_app/widgets/homePage.dart';
import 'package:instagram_demo_app/widgets/login/login_page.dart';
//import 'package:instagram_demo_app/widgets/root_page.dart';
import 'package:instagram_demo_app/widgets/profile/shipments_page.dart';
import 'package:instagram_demo_app/widgets/profile/tagged_shipments_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 786),
      builder: (context, child) => MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == '/shipments') {
            final int? index = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) => ShipmentsPage(initialIndex: index ?? 0),
            );
          }
          if (settings.name == '/taged_shipments') {
            final int? index = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) =>
                  TagedShipmentsPage(initialIndex: index ?? 0),
            );
          }
          if (settings.name == '/discover') {
            final int? index = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) =>
                  DiscoverDetailPage(initialIndex: index ?? 0),
            );
          }
          return MaterialPageRoute(
            builder: (context) => HomePage(),
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              // Oturum açık ise ana sayfaya yönlendir
              return HomePage();
            } else {
              // Oturum kapalı ise giriş sayfasını göster
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}