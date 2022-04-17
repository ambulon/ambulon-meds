import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';

class CustomAppBar {
  static AppBar def({
    title,
    context,
  }) {
    return AppBar(
      // leading: GestureDetector(
      //   onTap: () {
      //     Navigator.pop(context);
      //   },
      //   child: Icon(
      //     Icons.arrow_back_ios_outlined,
      //     size: ScreenUtil().setHeight(18),
      //     color: Colors.white,
      //   ),
      // ),
      backgroundColor: ColorTheme.greyDark,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }

  static AppBar defForCoupons({title, context, tablist}) {
    return AppBar(
      // leading: GestureDetector(
      //   onTap: () {
      //     Navigator.pop(context);
      //   },
      //   child: Icon(
      //     Icons.arrow_back_ios_outlined,
      //     size: ScreenUtil().setHeight(18),
      //     color: Colors.white,
      //   ),
      // ),
      backgroundColor: ColorTheme.greyDark,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
      bottom: TabBar(
        // padding: EdgeInsets.symmetric(horizontal: 20),
        labelPadding: EdgeInsets.all(6),
        indicatorWeight: 3,
        // indicatorColor: ColorTheme.green,
        tabs: tablist,
        labelStyle: TextStyle(fontSize: ScreenUtil().setHeight(15)),
      ),
    );
  }

  static AppBar defForSearchResult({
    title,
    context,
    backFunc,
    searchFunc,
    showSearchButton,
  }) {
    return AppBar(
      leading: GestureDetector(
        onTap: backFunc,
        child: Icon(
          Icons.arrow_back_ios_outlined,
          size: ScreenUtil().setHeight(18),
          color: Colors.white,
        ),
      ),
      actions: [
        showSearchButton
            ? GestureDetector(
                onTap: searchFunc,
                child: Icon(
                  Icons.search,
                  size: ScreenUtil().setHeight(25),
                  color: Colors.white,
                ),
              )
            : SizedBox(),
        SizedBox(width: ScreenUtil().setWidth(20)),
      ],
      backgroundColor: Colors.teal[600],
      centerTitle: true,
      title: Text(
        "$title",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  static AppBar cart({context, bool empty = false}) {
    return AppBar(
      centerTitle: true,
      // leading: GestureDetector(
      //   onTap: () {
      //     Navigator.pop(context);
      //   },
      //   child: Icon(
      //     Icons.arrow_back_ios_outlined,
      //     size: ScreenUtil().setHeight(18),
      //     color: Colors.black,
      //   ),
      // ),
      actions: empty
          ? []
          : [
              Icon(
                Icons.shopping_cart_outlined,
                size: ScreenUtil().setHeight(22),
                color: Colors.black,
              ),
              SizedBox(width: ScreenUtil().setWidth(20)),
            ],
      title: empty
          ? SizedBox()
          : Text(
              'Your Cart',
              style: TextStyle(
                color: ColorTheme.primaryColor,
                fontSize: ScreenUtil().setHeight(18),
              ),
            ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
