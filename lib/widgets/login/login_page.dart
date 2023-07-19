import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_demo_app/widgets/homePage.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String instaLogo = 'assets/images/Instagram-Logo.svg';
  final String instaBlackLogo = 'assets/images/Instagram-Black-Logo.svg';
  final String instaWhiteLogo = 'assets/images/Instagram-White-Logo.svg';

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
      bottomNavigationBar:
          Sabitler.login == 1 ? login_bottom_appbar() : signin_bottom_appbar(),
      //appBar: AppBar(title: Text("LoginPage")),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 712.h,
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

  BottomAppBar login_bottom_appbar() {
    return BottomAppBar(
      height: 75,
      color: Colors.black,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hesabınız Yok mu?',
                style: TextStyle(color: AppColors.greyShadeColor),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Sabitler.login = 0;
                    });
                  },
                  child: const Text(
                    'Kayıt Ol',
                    style:
                        TextStyle(fontSize: 14.5, color: AppColors.blueColor),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  BottomAppBar signin_bottom_appbar() {
    return BottomAppBar(
      height: 75,
      color: Colors.black,
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hesabınız Var mı?',
                style: TextStyle(color: AppColors.greyShadeColor),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      Sabitler.login = 1;
                    });
                  },
                  child: const Text(
                    'Giriş Yap',
                    style:
                        TextStyle(fontSize: 14.5, color: AppColors.blueColor),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  loginMethod() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(instaWhiteLogo),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _emailLoginController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'E Posta Adresi',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              controller: _passwordLoginController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: Colors.white,
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Şifre',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Şifreni mi Unuttun?',
                    style: TextStyle(color: AppColors.blueColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _loginUser();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'Giriş Yap',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.greyShadeColor,
                    thickness: 1,
                    height: 50,
                    endIndent: 20,
                  ),
                ),
                Text(
                  'Veya',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.greyShadeColor,
                    thickness: 1,
                    height: 50,
                    indent: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.backgroundColor,
              ),
              icon: const Icon(
                color: Colors.blue,
                Icons.facebook,
              ),
              label: const Text('Facebook ile Giriş Yap'),
            )
          ],
        ),
      ),
    );
  }

  signinMethod() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            SvgPicture.asset(instaWhiteLogo),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _userNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Kullanıcı Adı',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _emailLoginController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'E Posta Adresi',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Telefon Numarası',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true,
              controller: _passwordLoginController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                suffixIcon: const Icon(
                  Icons.visibility_off,
                  color: Colors.white,
                ),
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Şifre',
                hintStyle: const TextStyle(color: AppColors.greyShadeColor),
                fillColor: AppColors.greyColor,
                filled: true,
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Şifreni mi Unuttun?',
                    style: TextStyle(color: AppColors.blueColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _registerUser();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: const Text(
                'Kayıt Ol',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            const Row(
              children: [
                // Expanded(
                //   child: Divider(
                //     color: AppColors.greyShadeColor,
                //     thickness: 1,
                //     height: 50,
                //     endIndent: 20,
                //   ),
                // ),
                // Text(
                //   'Veya',
                //   style: TextStyle(
                //     color: AppColors.whiteColor,
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
            // const SizedBox(height: 20),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     elevation: 0,
            //     backgroundColor: AppColors.backgroundColor,
            //   ),
            //   icon: const Icon(
            //     Icons.facebook,
            //   ),
            //   label: const Text('Facebook ile Giriş Yap'),
            // )
          ],
        ),
      ),
    );
  }
}
