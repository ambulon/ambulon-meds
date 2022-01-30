import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/search.delegate.dart';

class CustomAppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: Styles.getWidth(context),
      height: Styles.getHeight(context),
      allowFontScaling: true,
    )..init(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.25), BlendMode.dstATop),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: Column(
        children: <Widget>[
          Spacer(),
          Row(
            children: [
              Text(
                'Search for Medicines',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setHeight(22),
                ),
              ),
              Spacer(),
              Icon(
                Icons.notifications,
                size: ScreenUtil().setHeight(30),
                color: Colors.white,
              ),
              SizedBox(width: ScreenUtil().setWidth(5)),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(45),
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(10)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorTheme.greyDark.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(width: ScreenUtil().setWidth(4)),
                Icon(
                  Icons.search,
                  color: ColorTheme.fontWhite,
                  size: ScreenUtil().setHeight(25),
                ),
                SizedBox(width: ScreenUtil().setWidth(8)),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(30),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        showSearch(context: context, delegate: MedicineSearch());
                      },
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setHeight(17)),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Search for anything',
                        hintStyle: TextStyle(fontSize: ScreenUtil().setHeight(17), color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
        ],
      ),
    );
  }
}
