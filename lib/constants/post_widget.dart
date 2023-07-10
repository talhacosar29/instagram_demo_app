import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_constants.dart';

class PostWidgetConstant {
  static PostView(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 0), // Gölgenin konumu
            blurRadius: 5.h, // Gölge bulanıklığı
            spreadRadius: 1.w, // Gölgenin yayılma miktarı
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      height: 570.h,
      width: double.infinity.w,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            height: 50.h,
            width: double.infinity.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.h,
                  width: 200.w,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/vesikalik.png'),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        Sabitler.FirebaseUserames[index],
                        style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 410.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Sabitler.FirebasePhotos[index]))),
          ),
          Container(
            height: 50.h,
            width: double.infinity.w,
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.mode_comment_outlined,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 20.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(left: 190.w),
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border_sharp,
                    size: 35.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${Sabitler.FirebasePhotoLikes[index]} beğenme",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Sabitler.FirebaseUserames[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    "gkofgksdfpgjdfjpk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
