import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/post_widget.dart';

class TagedShipmentsPage extends StatefulWidget {
  const TagedShipmentsPage({super.key});

  @override
  State<TagedShipmentsPage> createState() => _TagedShipmentsPageState();
}

class _TagedShipmentsPageState extends State<TagedShipmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Yönet",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.blue,
              ),
            ),
          )
        ],
        title: Text(
          "Etiketlendiklerin",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return PostWidgetConstant.PostView(index);
        },
        itemCount: 5,
      ),
    );
  }
}
