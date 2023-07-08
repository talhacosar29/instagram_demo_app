import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_demo_app/constants/app_constants.dart';
import 'package:instagram_demo_app/constants/post_widget.dart';
import 'package:instagram_demo_app/widgets/homePage.dart';

class ShipmentsPage extends StatefulWidget {
  const ShipmentsPage({super.key});

  @override
  State<ShipmentsPage> createState() => _ShipmentsPageState();
}

class _ShipmentsPageState extends State<ShipmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gönderiler",
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return PostWidgetConstant.PostView(index);
        },
        itemCount: 10,
      ),
    );
  }
}
