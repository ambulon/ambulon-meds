import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/profile_page.dart';
import 'package:medcomp/widget_constants/search.delegate.dart';
import 'package:medcomp/widget_constants/toast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomAppBarHome extends StatelessWidget {
  final name;
  final email;
  final photo;
  CustomAppBarHome({@required this.name, @required this.email, @required this.photo});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.primaryColor,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).padding.top,
            width: double.infinity,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            width: double.infinity,
            height: ScreenUtil().setHeight(30),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Search for Medicines',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setHeight(22),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (name == null || email == null || photo == null) {
                      ToastPreset.err(context: context, str: 'Not Logged in');
                    } else {
                      showBarModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (_) => ProfilePage(
                          email: email,
                          name: name,
                          photo: photo,
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.data_usage_rounded,
                    color: Colors.white,
                    size: ScreenUtil().setHeight(25),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(50),
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(10)),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: ScreenUtil().setHeight(30),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(5)),
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
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(30)),
        ],
      ),
    );
  }
}
