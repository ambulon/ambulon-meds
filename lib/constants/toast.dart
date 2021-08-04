import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';

class ToastPreset {
  static successful({@required String str, @required BuildContext context}) async {
    await showCupertinoDialog(
        context: context,
        builder: (_) => CustomToast(
              color: ColorTheme.green,
              isError: false,
              msg: str,
            ));
  }

  static err({@required String str, @required BuildContext context}) async {
    await showCupertinoDialog(
        context: context,
        builder: (_) => CustomToast(
              color: ColorTheme.red,
              isError: true,
              msg: str,
            ));
  }
}

class CustomToast extends StatefulWidget {
  final Color color;
  final String msg;
  final bool isError;
  CustomToast({this.color, this.msg, this.isError});

  @override
  _CustomToastState createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = new Timer(new Duration(seconds: 2), () {
      timer.cancel();
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
          child: ui(),
        ),
        SizedBox(height: ScreenUtil().setHeight(60)),
      ],
    );
  }

  Widget ui() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(10)),
          decoration: BoxDecoration(
            color: widget.color,
          ),
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    widget.isError ? Icons.cancel : Icons.check_circle,
                    color: Colors.white,
                    size: ScreenUtil().setHeight(16),
                  ),
                ),
                TextSpan(
                  text: "  ${widget.msg}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setHeight(15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
