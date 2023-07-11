import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homePage.dart';
import 'login_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Kullanıcı giriş yapmışsa HomePage'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Kullanıcı giriş yapmamışsa LoginPage'e yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
