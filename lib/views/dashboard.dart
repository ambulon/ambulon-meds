import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/bloc/profile.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/events/profile.event.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/cart/cart_page.dart';
import 'package:medcomp/views/home/components/profile_page.dart';
import 'package:medcomp/views/home/home.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEventLoadData());
    BlocProvider.of<CartBloc>(context).add(CartEventLoad());
    BlocProvider.of<ProfileBloc>(context).add(ProfileEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: Styles.getWidth(context),
      height: Styles.getHeight(context),
      allowFontScaling: true,
    )..init(context);

    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xfff1f3f8),
          selectedItemColor: Color(0xff011e33),
          unselectedItemColor: Color(0xff454646),
          iconSize: 20,
          unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setHeight(13)),
          selectedLabelStyle: TextStyle(fontSize: ScreenUtil().setHeight(13)),
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          currentIndex: _selectedIndex,
          items: [
            btn(icon: Icons.home, isSelected: _selectedIndex == 0, label: 'Home'),
            btn(icon: Icons.shopping_cart_outlined, isSelected: _selectedIndex == 1, label: 'Cart'),
            btn(icon: Icons.account_circle, isSelected: _selectedIndex == 2, label: 'Profile'),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: <Widget>[
            Stack(
              children: [
                Home(),
                Column(
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10),
                        horizontal: ScreenUtil().setWidth(15),
                      ),
                      child: cart(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                  ],
                ),
              ],
            ),
            CartPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem btn({label, icon, isSelected}) {
    return BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? Color(0xffc3e7fd) : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(14),
          vertical: ScreenUtil().setHeight(4),
        ),
        margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(4)),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  Widget cart() {
    int iconH = 42;
    int iconG = 10;
    double border = 12;
    return GestureDetector(
      onTap: () {
        _pageController.jumpToPage(1);
        setState(() {
          _selectedIndex = 1;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(iconG),
          horizontal: ScreenUtil().setWidth(iconG),
        ),
        decoration: BoxDecoration(
          color: ColorTheme.greyDark,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(border),
        ),
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setHeight(iconH),
              height: ScreenUtil().setHeight(iconH),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorTheme.fontBlack.withOpacity(0.5),
                    ColorTheme.fontBlack,
                  ],
                ),
                borderRadius: BorderRadius.circular(border - 3),
              ),
              child: Icon(
                Icons.shopping_cart,
                size: ScreenUtil().setHeight(20),
                color: ColorTheme.fontWhite,
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(13)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your cart',
                  style: TextStyle(
                    color: ColorTheme.fontWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setHeight(15),
                  ),
                ),
                Text(
                  'Tap to view your cart items',
                  style: TextStyle(
                    color: ColorTheme.fontWhite,
                    fontSize: ScreenUtil().setHeight(13),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorTheme.grey,
              size: ScreenUtil().setHeight(23),
            ),
          ],
        ),
      ),
    );
  }
}
