import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';

class DefaultWidgets {
  static Widget headline({
    @required String str,
    @required bool small,
    @required bool verticalMargin,
    bool showAll = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(verticalMargin ? 10 : 0),
        horizontal: ScreenUtil().setWidth(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              str,
              style: TextStyle(
                fontSize: ScreenUtil().setHeight(small ? 16 : 18),
                color: Colors.black,
                fontWeight: small ? FontWeight.w600 : FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(10)),
          showAll
              ? Text(
                  'view all',
                  style: TextStyle(
                    fontSize: ScreenUtil().setHeight(13),
                    color: ColorTheme.bgColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
