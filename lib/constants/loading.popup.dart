import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoadingPopupGenerator {
  static def({@required text, @required context}) {
    showCupertinoDialog(
      context: context,
      builder: (_) => LoadingPopup(text: text),
    );
  }
}

class LoadingPopup extends StatefulWidget {
  final String text;
  LoadingPopup({@required this.text});
  @override
  _LoadingPopupState createState() => _LoadingPopupState();
}

class _LoadingPopupState extends State<LoadingPopup> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    var clipRRect = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        child: Container(
          padding: EdgeInsets.all(30),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.text}",
                  style: TextStyle(
                    color: ColorTheme.fontBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: LinearProgressIndicator(backgroundColor: ColorTheme.greyDark),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
    return Column(
      children: <Widget>[
        Spacer(),
        ScreenTypeLayout(
          mobile: Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(15)),
            child: clipRRect,
          ),
          desktop: Container(
            width: ScreenUtil().setWidth(Styles.wForLaptop),
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(15)),
            child: clipRRect,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
