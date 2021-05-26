import 'dart:io';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/bloc/homemed.bloc.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/events/homemed.event.dart';
import 'package:medcomp/models/user.model.dart';
import 'package:medcomp/states/home.state.dart';
import 'package:medcomp/states/homemed.state.dart';
import 'package:medcomp/views/cart/cart_page.dart';
import 'package:medcomp/widget_constants/headline.dart';
import 'package:medcomp/widget_constants/loader.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEventLoadData());
    BlocProvider.of<HomeMedBloc>(context).add(HomeMedEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
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
        return;
      },
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
            return loadPage(null);
          }
          if (state is HomeStateLoaded) {
            return loadPage(state.userModel);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget loadPage(UserModel user) {
    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: ColorTheme.primaryColor,
            expandedHeight: ScreenUtil().setHeight(170),
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBarHome(
                email: user?.email,
                name: user?.name,
                photo: user?.photoUrl,
              ),
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
                        showAll: false,
                        showAllFunc: () {},
                      ),
                      PopularSearches(),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      // savedMedsWidget(),
                      createCartWidget(),
                      SizedBox(height: ScreenUtil().setHeight(12)),
                      BlocConsumer<HomeMedBloc, HomeMedState>(
                        listener: (ctx, HomeMedState state) {},
                        builder: (ctx, HomeMedState state) {
                          if (state is HomeMedStateLoading) {
                            return Loader.medCardShimmer();
                          }
                          if (state is HomeMedStateLoaded) {
                            return MedicineComparisionList.list(
                              str: state.model.name,
                              medlist: state.model.list,
                              compact: true,
                              context: context,
                            );
                          }
                          return SizedBox();
                        },
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
    );
  }

  Widget createCartWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CartPage()),
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
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: ScreenUtil().setHeight(35),
                  ),
                ),
              ),
              Text(
                'Your Cart',
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
    );
  }

  Widget savedMedsWidget() {
    return GestureDetector(
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
    );
  }
}
