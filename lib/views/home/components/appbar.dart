import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/models/user.model.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/cart/cart_page.dart';
import 'package:medcomp/views/home/components/profile_page.dart';
import 'package:medcomp/constants/search.delegate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomAppBarHome extends StatelessWidget {
  final UserModel user;
  CustomAppBarHome({@required this.user});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
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
          Container(
            height: MediaQuery.of(context).padding.top,
            width: double.infinity,
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartPage()),
                  );
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: ScreenUtil().setHeight(30),
                  color: ColorTheme.fontWhite.withOpacity(0.7),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    enableDrag: true,
                    builder: (_) => ProfilePage(
                      email: user.email ?? "",
                      name: user.name ?? "",
                      photo: user.photoUrl ?? "",
                    ),
                  );
                },
                child: Container(
                  height: ScreenUtil().setWidth(35),
                  width: ScreenUtil().setWidth(35),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(user.photoUrl)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Search for Medicines',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setHeight(22),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(55),
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(10)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorTheme.greyDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: ColorTheme.fontWhite,
                  size: ScreenUtil().setHeight(30),
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
          SizedBox(height: ScreenUtil().setHeight(30)),
        ],
      ),
    );
  }
}
