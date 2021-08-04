import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/utils/styles.dart';

class SavedMeds extends StatefulWidget {
  @override
  _SavedMedsState createState() => _SavedMedsState();
}

class _SavedMedsState extends State<SavedMeds> {
  Widget noItem() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Text(
          'No data found, add your regular medicines here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: ScreenUtil().setHeight(15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return Scaffold(
      appBar: CustomAppBar.def(title: 'Saved Items', context: context),
      body: noItem(),
    );
  }
}
