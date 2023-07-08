import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_constants.dart';

class PostWidgetConstant
{
  static PostView(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
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
              children: [
                SizedBox(
                  width: 15.w,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/vesikalik.png'),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "talhacosar29",
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 165.w,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 410.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(Sabitler.ProfilResimler[index]))),
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
                "5.050 beğenme",
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
                  "talhacosar29",
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