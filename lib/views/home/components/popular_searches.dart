import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';

class PopularSearches extends StatefulWidget {
  @override
  _PopularSearchesState createState() => _PopularSearchesState();
}

class _PopularSearchesState extends State<PopularSearches> {
  bool isTablet;
  List searches = [
    'Paracetamol',
    'Crocin',
    'Zip Mox',
    'Nici Plus',
    'RCinex',
  ];

  Widget categorySlot(String name) {
    String tempname = name.replaceAll(' ', '\n');
    tempname = tempname.replaceAll('and\n', '& ');
    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {},
            child: CircleAvatar(
              backgroundColor: Colors.orangeAccent,
              radius: isTablet ? ScreenUtil().setWidth(60) : MediaQuery.of(context).size.width * 0.10,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(7)),
          Text(
            "$tempname",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    isTablet = MediaQuery.of(context).size.width > 730;
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(2)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < searches.length; i++) categorySlot(searches[i]),
          ],
        ),
      ),
    );
  }
}
