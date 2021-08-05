import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/products_grid.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/states/home.state.dart';
import 'package:medcomp/views/cart/cart_page.dart';
import 'package:medcomp/views/login/login_page.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'components/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext ctx, HomeState state) {},
        builder: (BuildContext ctx, HomeState state) {
          if (state is HomeStateNotLoaded) {
            return SizedBox();
          }
          if (state is HomeStateLoading) {
            return Loader.def();
          }
          if (state is HomeStateError) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('error'),
              ),
              body: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginPage(),
                      ),
                    );
                  },
                  child: Text('please login first'),
                ),
              ),
            );
          }
          if (state is HomeStateLoaded) {
            return Scaffold(
              backgroundColor: ColorTheme.grey,
              body: Stack(
                children: [
                  CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: ColorTheme.grey,
                        expandedHeight: ScreenUtil().setHeight(210),
                        flexibleSpace: FlexibleSpaceBar(
                          background: CustomAppBarHome(user: state.userModel),
                          centerTitle: true,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10),
                                horizontal: ScreenUtil().setWidth(15),
                              ),
                              margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                              decoration: BoxDecoration(
                                boxShadow: kElevationToShadow[8],
                                color: ColorTheme.fontWhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  topLeft: Radius.circular(7),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(12)),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'More Products',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorTheme.fontBlack,
                                      ),
                                    ),
                                  ),
                                  ProductsGrid(['', '', '', '', '']),
                                ],
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
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
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget cart() {
    int iconH = 52;
    int iconG = 14;
    double border = 12;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CartPage()),
        );
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
                size: ScreenUtil().setHeight(25),
                color: ColorTheme.fontWhite,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your cart',
                  style: TextStyle(
                    color: ColorTheme.fontWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setHeight(16),
                  ),
                ),
                Text(
                  'Tap to view your cart items',
                  style: TextStyle(
                    color: ColorTheme.fontWhite,
                    fontSize: ScreenUtil().setHeight(14),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorTheme.grey,
              size: ScreenUtil().setHeight(25),
            ),
          ],
        ),
      ),
    );
  }
}
