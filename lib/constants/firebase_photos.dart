import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/homePage.dart';

class FirebasePhoto {
  static List<String> photoUrls = [];
  Future<List<String>> getPhotoUrls() async {
    final user = FirebaseAuth.instance.currentUser;
    final firestoreRef =
        FirebaseFirestore.instance.collection('users').doc(user?.uid);

    final snapshot = await firestoreRef.get();
    if (snapshot.exists) {
      final data = snapshot.data();
      final imageUrlList = data!['photoUrl'] as List<dynamic>;
      photoUrls = imageUrlList.map((imageUrl) => imageUrl.toString()).toList();
    }

    return photoUrls;
  }

  Future<void> pickAndUploadImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile);

      final imageUrl = await storageRef.getDownloadURL();

      final firestoreRef = FirebaseFirestore.instance.collection('users').doc();
      await firestoreRef.set({
        'photoUrl': imageUrl,
        'uploadDate': DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));

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
