import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Styles {
  static const int h_small_for_loginpage = 730;
  static const int hSmall = 700;
  static const int wSmall = 410;
  static const int hMedium = 900;
  static const int wMedium = 520;
  static const int hLarge = 1100;
  static const int wLarge = 700;
  static const int hTablet = 1200;
  static const int wTablet = 800;

  static getWidth(context) {
    double deviceW = MediaQuery.of(context).size.width;
    if (deviceW < 420) {
      return wSmall;
    } else if (deviceW < 500) {
      return wMedium;
    } else if (deviceW < 790) {
      return wLarge;
    } else {
      return deviceW.toInt();
    }
  }

  static getHeight(context) {
    double deviceH = MediaQuery.of(context).size.height;
    if (deviceH < 700) {
      return hSmall;
    } else if (deviceH < 1000) {
      return hMedium;
    } else if (deviceH < 1190) {
      return hLarge;
    } else {
      return hTablet;
    }
  }

  static get wForLaptop {
    return wSmall;
  }

  static Widget responsiveBuilder(page) {
    return ScreenTypeLayout(
      mobile: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: page,
        ),
      ),
      desktop: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: ScreenUtil().setWidth(Styles.wForLaptop),
            child: page,
          ),
        ),
      ),
    );
  }

  static Widget responsivePopupBuilder(content) {
    return ScreenTypeLayout(
      mobile: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15), vertical: ScreenUtil().setHeight(15)),
        child: content,
      ),
      desktop: Container(
        width: ScreenUtil().setWidth(Styles.wForLaptop),
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15), vertical: ScreenUtil().setHeight(15)),
        child: content,
      ),
    );
  }

  static Widget rippleBuilder({Widget child}) {
    return Container(
      color: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
