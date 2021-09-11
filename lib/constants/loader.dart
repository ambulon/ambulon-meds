import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/constants/quotes.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class Loader {
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: ScreenUtil().setWidth(10)),
          Text("Loading"),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget def() {
    return Scaffold(
      body: Center(
        child: Text('loading'),
      ),
    );
  }

  static Widget gifLoader(context) {
    return Styles.responsiveBuilder(
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Styles.getHeight(context) * 0.4,
            height: Styles.getHeight(context) * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('loader-logo.jpeg'),
              fit: BoxFit.contain,
            )),
          ),
          SizedBox(height: 40),
          Container(
            width: Styles.getWidth(context) * 0.75,
            alignment: Alignment.center,
            child: Text(
              Quotes.randomQuote,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget medCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFEBEBF4),
      highlightColor: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(8),
        ),
        height: ScreenUtil().setHeight(110),
        child: Row(
          children: [
            Expanded(flex: 3, child: SizedBox()),
            Expanded(flex: 7, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
