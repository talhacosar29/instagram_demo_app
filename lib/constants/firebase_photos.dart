import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/homePage.dart';

class FirebasePhoto {
  Future<void> pickAndUploadImage(BuildContext context) async {
    var usernameData;
    bool? userIdControl;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var userPost = await _firestore.collection("users").get();

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('instagram/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile);

      final imageUrl = await storageRef.getDownloadURL();
      final user = FirebaseAuth.instance.currentUser;

      for (var post in userPost.docs) {
        usernameData = post.data()['user_name'];
        if (post.data()['user_id'] == user?.uid) {
          userIdControl = true;
          break;
        }
      }

      final firestoreRef = _firestore.collection('posts').doc();
      if (userIdControl == true) {
        await firestoreRef.set({
          'comment_count': 0,
          'comments': [],
          'likes': 0,
          'photoUrl': imageUrl,
          'uploadDate': DateTime.now(),
          'userName': usernameData,
          'user_id': user?.uid
        }, SetOptions(merge: true));
      }

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Başarılı'),
            content: Text('Fotoğraf yüklendi!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata'),
            content: Text('Fotoğraf seçilemedi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }
}
