import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';

class ToastPreset {
  static successful({String str, @required BuildContext context}) {
    showCupertinoDialog(
        context: context,
        builder: (_) => Toast(
              color: ColorTheme.green,
              isError: false,
              msg: str,
            ));
  }

  static err({String str, @required BuildContext context}) {
    showCupertinoDialog(
        context: context,
        builder: (_) => Toast(
              color: ColorTheme.red,
              isError: true,
              msg: str,
            ));
  }
}

class Toast extends StatefulWidget {
  final Color color;
  final String msg;
  final bool isError;
  Toast({this.color, this.msg, this.isError});

  @override
  _ToastState createState() => _ToastState();
}

class _ToastState extends State<Toast> {
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
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true);
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Material(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                decoration: BoxDecoration(
                  color: widget.color,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      widget.isError ? Icons.cancel : Icons.check_circle,
                      color: Colors.white,
                      size: ScreenUtil().setHeight(20),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    Text(widget.msg,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: ScreenUtil().setHeight(15))),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(60)),
      ],
    );
  }
}
