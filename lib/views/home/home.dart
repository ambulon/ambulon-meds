import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/error.dart';
import 'package:medcomp/constants/loader.dart';
import 'package:medcomp/constants/products_grid.dart';
import 'package:medcomp/constants/quotes.dart';
import 'package:medcomp/models/banner.model.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/states/home.state.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/coupons.dart';
import 'package:medcomp/views/search/search_result_page.dart';
import 'components/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    firebaseMessaging.configure(
      onMessage: (message) {
        print("onMessage $message");
        return;
      },
      onLaunch: (message) {
        print("onLaunch $message");
        return;
      },
      onResume: (message) {
        print("onResume $message");
        return;
      },
    );
    firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
      width: Styles.getWidth(context),
      height: Styles.getHeight(context),
      allowFontScaling: true,
    )..init(context);
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext ctx, HomeState state) {},
      builder: (BuildContext ctx, HomeState state) {
        if (state is HomeStateNotLoaded) {
          return SizedBox();
        }
        if (state is HomeStateLoading) {
          return Loader.def();
        }
        if (state is HomeStateError) {
          return ErrorPage(message: state.message, gotoLogin: true);
        }
        if (state is HomeStateLoaded) {
          return pageBuild(state, state.topPicks);
        }
        if (state is HomeStateTopPicksLoading) {
          return pageBuild(state, []);
        }
        return SizedBox();
      },
    );
  }

  Widget pageBuild(state, List<MedicineModel> topPicks) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorTheme.grey,
            expandedHeight: ScreenUtil().setHeight(150),
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBarHome(),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return body(state, topPicks);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget body(state, List<MedicineModel> topPicks) {
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
          SizedBox(height: ScreenUtil().setHeight(15)),
          state.banners.length == 0
              ? SizedBox()
              : Container(
                  child: CarouselSlider(
                    items: [
                      for (BannerModel i in state.banners)
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: i.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enableInfiniteScroll: true,
                      aspectRatio: 2.2,
                      autoPlayAnimationDuration: Duration(milliseconds: 1600),
                    ),
                  ),
                ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          singleCoupon(),
          Divider(thickness: 1, height: ScreenUtil().setHeight(20)),
          SizedBox(height: ScreenUtil().setHeight(10)),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'View Coupons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorTheme.fontBlack,
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(8)),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CouponsPage()));
            },
            child: Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(200),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://firebasestorage.googleapis.com/v0/b/ambulon-316f1.appspot.com/o/view_coupon.png?alt=media&token=ee465542-e901-4f97-a1b6-dc9a65fa131b',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(30)),
          state.searchHistory.length == 0 || kIsWeb
              ? SizedBox()
              : Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Searches',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.fontBlack,
                        ),
                      ),
                    ),
                    kIsWeb ? SizedBox() : SizedBox(height: ScreenUtil().setHeight(2)),
                    kIsWeb
                        ? SizedBox()
                        : Container(
                            child: GridView.count(
                              padding: EdgeInsets.zero,
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                state.searchHistory.length,
                                (index) {
                                  return searchBox(state.searchHistory[index]);
                                },
                              ),
                            ),
                          ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                  ],
                ),
          Divider(thickness: 1, height: ScreenUtil().setHeight(20)),
          SizedBox(height: ScreenUtil().setHeight(20)),
          topPicks.length == 0
              ? SizedBox()
              : Container(
                  child: Row(
                    children: [
                      Text(
                        'Top Picks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.fontBlack,
                        ),
                      ),
                      Spacer(),
                      // InkWell(
                      //   onTap: () {
                      //     BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshToppicks());
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.add_box,
                      //         size: ScreenUtil().setHeight(25),
                      //         color: ColorTheme.blue,
                      //       ),
                      //       SizedBox(width: ScreenUtil().setWidth(5)),
                      //       Text(
                      //         'view more',
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //           color: ColorTheme.blue,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
          ProductsGrid(topPicks),
          SizedBox(height: ScreenUtil().setHeight(120)),
        ],
      ),
    );
  }

  Widget singleCoupon() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setWidth(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Compare Medicine Prices",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(15),
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.fontBlack,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  child: Text(
                    "Search for the medicines and pick\nthe best sites to buy them and enjoy coupons",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(14),
                      color: ColorTheme.grey,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Container(
                  child: Text(
                    "Save upto 40% off",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(13),
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.green,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                ElevatedButton(
                  child: Text(
                    "View coupons",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.fontWhite,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(ColorTheme.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CouponsPage()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Expanded(
            flex: 4,
            child: CachedNetworkImage(
              imageUrl: 'https://cdn-icons-png.flaticon.com/512/4861/4861715.png',
              height: ScreenUtil().setHeight(100),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox(SearchHistoryModel model) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SearchResult(
                str: model.name,
                preset: true,
              ),
            ),
          );
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              CircleAvatar(
                radius: Styles.getWidth(context) / 10,
                backgroundColor: ColorTheme.grey,
                backgroundImage: NetworkImage(model.image),
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              Container(
                child: Text(
                  model.name,
                  style: TextStyle(
                    color: ColorTheme.fontBlack,
                    fontSize: ScreenUtil().setHeight(14),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loading() {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: ColorTheme.fontWhite,
      ),
      child: Column(
        children: [
          Expanded(flex: 3, child: SizedBox()),
          Hero(
            tag: 'logo',
            child: Container(
              child: Image(
                height: ScreenUtil().setHeight(120),
                width: ScreenUtil().setHeight(120),
                image: AssetImage('assets/app-logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: ScreenUtil().setWidth(60),
            child: LinearProgressIndicator(
              color: ColorTheme.red.withOpacity(0.6),
              backgroundColor: ColorTheme.blue.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 40),
          Container(
            width: Styles.getWidth(context) * 0.75,
            alignment: Alignment.center,
            child: Text(
              Quotes.randomQuote,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Expanded(flex: 6, child: SizedBox()),
        ],
      ),
    );
  }
}
