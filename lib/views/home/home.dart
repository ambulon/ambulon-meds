import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/widget_constants/headline.dart';
import 'package:medcomp/widget_constants/med_card.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/popular_searches.dart';
import 'package:medcomp/views/saved/saved.dart';
import 'components/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            child: CupertinoAlertDialog(
              title: Text("Quit App"),
              content: Text("Are you sure you want to exit the app?"),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Nope")),
                CupertinoDialogAction(
                    textStyle: TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    onPressed: () async {
                      // Navigator.pop(context);
                      exit(0);
                    },
                    child: Text("Yes, sure")),
              ],
            ));
      },
      child: Scaffold(
        backgroundColor: ColorTheme.bgColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: ColorTheme.bgColor,
              expandedHeight: ScreenUtil().setHeight(170),
              flexibleSpace: FlexibleSpaceBar(
                background: CustomAppBarHome(),
                centerTitle: true,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        DefaultWidgets.headline(
                          str: 'Popular Searches',
                          small: false,
                          verticalMargin: true,
                        ),
                        PopularSearches(),
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SavedMeds()),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: ScreenUtil().setHeight(110),
                            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(15)),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.teal[600],
                                Colors.teal[800],
                              ]),
                              boxShadow: kElevationToShadow[2],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FDottedLine(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                    dottedLength: 10.0,
                                    space: 2.0,
                                    corner: FDottedLineCorner.all(8),
                                    height: ScreenUtil().setHeight(90),
                                    width: ScreenUtil().setHeight(90),
                                    child: Container(
                                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: ScreenUtil().setHeight(35),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Saved Items',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setHeight(13),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12)),
                        MedicineComparisionList.list(
                          str: 'Para',
                          medlist: ['', '', '', '', '', '', ''],
                          compact: true,
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12)),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
