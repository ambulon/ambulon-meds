import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar {
  static AppBar def({
    title,
    context,
  }) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: ScreenUtil().setHeight(18),
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.teal[600],
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
