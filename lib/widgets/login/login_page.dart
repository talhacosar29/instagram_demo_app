import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_demo_app/widgets/homePage.dart';

import '../../constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailLoginController.text.trim(),
        password: _passwordLoginController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        Fluttertoast.showToast(
            msg: 'Giriş başarılı. Kullanıcı ID: ${user.uid}');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text(
                'Giriş başarısız. Lütfen geçerli bir e-posta ve şifre girin.'),
            actions: [
              TextButton(
                child: Text('Tamam'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailLoginController.text.trim(),
        password: _passwordLoginController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        final firestoreRef =
            FirebaseFirestore.instance.collection('users').doc();
        await firestoreRef.set({
          'phoneNumber': _phoneNumberController.text.toString(),
          'user_mail': _emailLoginController.text.toString(),
          'user_name': _userNameController.text.toString(),
          'user_id': user.uid.toString(),
          'firestore_id': firestoreRef.id.toString(),
        }, SetOptions(merge: true));
        Fluttertoast.showToast(
            msg: 'Kayıt başarılı. Kullanıcı ID: ${user.uid}');
        setState(() {
          Sabitler.login = 1;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Kayıt hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("LoginPage")),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 786.h,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            width: double.infinity,
            child: Sabitler.login == 1 ? loginMethod() : signinMethod(),
          ),
        ),
      ),
    );
  }

  signinMethod() {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
        ),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Kayıt Ol",
                  style: TextStyle(color: Colors.white, fontSize: 40.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Instagram Clone Uygulamasına Hoşgeldiniz",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 600.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.w),
                topRight: Radius.circular(60.w),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.only(left: 30, right: 30),
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _userNameController,
                    decoration: InputDecoration(
                      hintText: "Kullanıcı Adı",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailLoginController,
                    decoration: InputDecoration(
                      hintText: "E Posta Adresi",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      hintText: "Telefon Numarası",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    obscureText: true,
                    controller: _passwordLoginController,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _registerUser();
                  },
                  // Kayıt Ol Butonu
                  child: Container(
                    height: 50.h,
                    margin: EdgeInsets.only(
                        left: 50.w, right: 50, top: 30.h, bottom: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.8), // Gölgelendirme rengi
                          spreadRadius: 5.w, // Gölgelendirme genişliği
                          blurRadius: 7.w, // Gölgelendirme bulanıklığı
                          offset: Offset(0, 3), // Gölgelendirme ofseti (x, y)
                        ),
                      ],
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Center(
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  // Giriş Sayfasona Yönlendir
                  onTap: () {
                    setState(() {
                      Sabitler.login = 1;
                    });
                  },
                  child: Text(
                    "Giriş Yapmak İçin Tıklayınız",
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  loginMethod() {
    return Column(
      children: [
        SizedBox(
          height: 120.h,
        ),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Giriş Yap",
                  style: TextStyle(color: Colors.white, fontSize: 40.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  "Istagram Clone Uygulamasına Hoşgeldiniz",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 600.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60.w),
                topRight: Radius.circular(60.w),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.only(left: 30, right: 30),
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _emailLoginController,
                    decoration: InputDecoration(
                      hintText: "E Posta Adresi",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  margin: EdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    controller: _passwordLoginController,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      hintStyle: TextStyle(color: Colors.grey.shade100),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Text(
                  "Şifreni mi Unuttun?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade300),
                ),

                // Giriş Yap Butonu
                GestureDetector(
                  onTap: () {
                    _loginUser();
                  },
                  child: Container(
                    height: 50.h,
                    margin:
                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.8), // Gölgelendirme rengi
                          spreadRadius: 5.w, // Gölgelendirme genişliği
                          blurRadius: 7.w, // Gölgelendirme bulanıklığı
                          offset: Offset(0, 3), // Gölgelendirme ofseti (x, y)
                        ),
                      ],
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Center(
                      child: Text(
                        "Giriş Yap",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      Sabitler.login = 0;
                    });
                  },
                  child: Text(
                    "Kayıt Olmak İçin Tıklayınız",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
