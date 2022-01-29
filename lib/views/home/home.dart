import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/error.dart';
import 'package:medcomp/constants/products_grid.dart';
import 'package:medcomp/constants/quotes.dart';
import 'package:medcomp/events/home.event.dart';
import 'package:medcomp/models/banner.model.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/second_screen.dart';
import 'package:medcomp/states/home.state.dart';
import 'package:medcomp/third_screen.dart';
import 'package:medcomp/views/cart/cart_page.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/views/home/components/coupons.dart';
import 'package:medcomp/views/search/search_result_page.dart';
import 'package:medcomp/views/splash_screen.dart';
import 'components/appbar.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeEventLoadData());
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
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
            return loading();
          }
          if (state is HomeStateError) {
            return Styles.responsiveBuilder(ErrorPage(
              message: state.message,
              gotoLogin: true,
            ));
            // return Text(state.message);
          }
          if (state is HomeStateLoaded) {
            return Styles.responsiveBuilder(page(state, state.topPicks));
          }
          if (state is HomeStateTopPicksLoading) {
            return Styles.responsiveBuilder(page(state, []));
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget page(state, List<MedicineModel> topPicks) => Scaffold(
        backgroundColor: Color(0xffA0A6A9),
        bottomNavigationBar: BottomNavigationBar(
     selectedItemColor: Colors.black,
     unselectedItemColor: Colors.grey[500],
     type:BottomNavigationBarType.shifting,
     onTap: _onTap,
    currentIndex: _selectedIndex,
     items: [
       BottomNavigationBarItem(
         icon: Icon(Icons.home), 
         label: 'Home',
         ),
        BottomNavigationBarItem(
         icon: Icon(Icons.filter_alt), 
         label: 'Filter',
         ),
         BottomNavigationBarItem(
         icon: Icon(Icons.favorite), 
         label: 'Favourite',
         ), 
     ],
     ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
          Stack(
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
                                SizedBox(height: ScreenUtil().setHeight(15)),
                                state.banners.length == 0
                                    ? SizedBox()
                                    : Container(
                                        height: ScreenUtil().setHeight(200),
                                        child: CarouselSlider(
                                          items: [
                                            for (BannerModel i in state.banners)
                                              Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(i.image),
                                              ),
                                              ],
                                          options: CarouselOptions(
                                            height: ScreenUtil().setHeight(200),
                                            enlargeCenterPage: true,
                                            autoPlay: true,
                                           // reverse: true,
                                            autoPlayCurve: Curves.easeInOut,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                                          ),
                                        ),
                                        ),       
                                SizedBox(height: ScreenUtil().setHeight(20)),
                                Container(
                                  child:Row(
                                      children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Container(
                                           child:Text("Order Medicine",
                                           textAlign: TextAlign.left,
                                           style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.fontBlack,
                                            ),),
                                           padding: EdgeInsets.only(top:7, bottom: 3, left: 10),
                                           alignment: Alignment.centerLeft,
                                           ),
                                           Container(
                                           child:Text("Upload Prescription and tell \nus what you need. We do the \nrest.",
                                           textAlign: TextAlign.left,
                                           style: TextStyle(
                                              fontSize: 11,
                                              color: ColorTheme.grey,
                                            ),
                                            ),
                                           padding: EdgeInsets.only(bottom: 3, left: 10),
                                           alignment: Alignment.centerLeft,
                                           ),
                                           SizedBox(height: ScreenUtil().setHeight(10),),
                                           Container(
                                           child:Text("Save upto 60% off",
                                           textAlign: TextAlign.left,
                                           style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.green,
                                            ),
                                            ),
                                           padding: EdgeInsets.only(top:3, bottom: 3, left: 10),
                                           alignment: Alignment.centerLeft,
                                           ), 
                                          SizedBox(height: ScreenUtil().setHeight(10),),
                                          Container(
                                           child:ElevatedButton(
                                            child: Text("Order now", 
                                            style: TextStyle(fontWeight: FontWeight.bold, color: ColorTheme.fontWhite)),
                                           style: ButtonStyle(
                                             backgroundColor: MaterialStateProperty.all<Color>(Colors.teal[400],),
                                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                              )
                                            )
                                          ),
                                            onPressed: (){},
                                            ),
                                           padding: EdgeInsets.only(bottom: 3, left: 10),
                                           alignment: Alignment.centerLeft,
                                           ),    
                                    ],
                                    ),
                                      SizedBox(width: ScreenUtil().setWidth(60),),
                                      Image.network('https://cdn-icons-png.flaticon.com/512/4861/4861715.png',
                                      width: 120,
                                      height: 120,
                                      ),  
                                    ],
                                    ),
                                  ),
                                SizedBox(height: ScreenUtil().setHeight(20)),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'View Coupons',
                                    style: TextStyle(
                                      fontSize: 16,
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
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage('assets/coupons.png'),
                                      fit: BoxFit.cover,
                                    )),
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
                                                fontSize: 16,
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
                                          SizedBox(height: ScreenUtil().setHeight(30)),
                                        ],
                                      ),
                                topPicks.length == 0
                                    ? SizedBox()
                                    : Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              'Top Picks',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: ColorTheme.fontBlack,
                                              ),
                                            ),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                BlocProvider.of<HomeBloc>(context).add(HomeEventRefreshToppicks());
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.add_box,
                                                    size: ScreenUtil().setHeight(25),
                                                    color: ColorTheme.blue,
                                                  ),
                                                  SizedBox(width: ScreenUtil().setWidth(5)),
                                                  Text(
                                                    'view more',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                      color: ColorTheme.blue,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                ProductsGrid(topPicks),
                                SizedBox(height: ScreenUtil().setHeight(120)),
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
      Second(), //extra screens
      Third(),
    ],
  ),
      );

      void _onTap(int idx) {
        setState(() {
          _selectedIndex = idx;
          });
        _pageController.jumpToPage(idx);
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
    return Scaffold(
      backgroundColor: ColorTheme.fontWhite,
      body: Container(
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
      ),
    );
  }

  Widget cart() {
    int iconH = 46;
    int iconG = 12;
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
