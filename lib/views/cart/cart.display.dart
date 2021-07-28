import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/widget_constants/med_card_cart.dart';
import 'package:medcomp/widget_constants/toast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/rendering.dart';

class CartDisplay extends StatefulWidget {
  final CartModel cartModel;
  CartDisplay({this.cartModel});
  @override
  _CartDisplayState createState() => _CartDisplayState();
}

class _CartDisplayState extends State<CartDisplay> {
  PageController pageController = PageController(initialPage: 0);
  List<GlobalKey> _globalKey = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar.cart(context: context),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      content(i: 0, title: 'Best', totalPrice: widget.cartModel.totalPrice.minPrice),
                      content(i: 1, title: 'Netmeds', totalPrice: widget.cartModel.totalPrice.netmeds),
                      content(i: 2, title: '1mg', totalPrice: widget.cartModel.totalPrice.i1mg),
                      content(i: 3, title: 'Apollo', totalPrice: widget.cartModel.totalPrice.apollo),
                    ],
                  ),
                  Align(
                    alignment: Alignment(-1, -1),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setHeight(20), 0, 0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 4,
                        axisDirection: Axis.horizontal,
                        onDotClicked: (i) {
                          pageController.animateToPage(
                            i,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        effect: ExpandingDotsEffect(
                          expansionFactor: 2,
                          spacing: 8,
                          radius: 8,
                          dotWidth: 8,
                          dotHeight: 8,
                          dotColor: Color(0xFF9E9E9E),
                          activeDotColor: ColorTheme.primaryColor,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                clearButton(),
                // TODO : LATER : Add visit site button
                // shareButton(),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
          ],
        ),
      ),
    );
  }

  double titleToPrice(title, Price price) {
    switch (title) {
      case 'Best':
        return price.minPrice;
      case 'Netmeds':
        return price.netmeds;
      case '1mg':
        return price.i1mg;
      case 'Apollo':
        return price.apollo;
      default:
        return 0.0;
    }
  }

  Widget content({
    int i,
    String title,
    double totalPrice,
  }) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey[i],
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(12)),
                Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(25),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                    title == 'Best'
                        ? 'Best Price : \₹ ${totalPrice.toStringAsFixed(2)}'
                        : 'Total Price : \₹ ${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(15),
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(12)),
                for (var item in widget.cartModel.items)
                  MedCardCart(
                    price: titleToPrice(title, item.price),
                    item: item,
                    // name: item.name,
                    // quantity: item.quantity,
                    // id: item.id,
                  ),
                // SizedBox(height: ScreenUtil().setHeight(12)),
                // Text(
                //   'Stay Safe - www.ambulon.com',
                //   style: TextStyle(
                //     color: Colors.grey[800],
                //     fontSize: ScreenUtil().setHeight(11),
                //   ),
                // ),
                SizedBox(height: ScreenUtil().setHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector clearButton() {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CartBloc>(context).add(CartEventClearCart());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setHeight(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: ColorTheme.primaryColor.withOpacity(0.5),
          border: Border.all(color: ColorTheme.primaryColor.withOpacity(0.7), width: 4),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.clear,
                color: ColorTheme.primaryColor,
                size: ScreenUtil().setHeight(20),
              ),
              SizedBox(width: ScreenUtil().setWidth(8)),
              Text(
                'Clear',
                style: TextStyle(
                  color: ColorTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setHeight(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector shareButton() {
    return GestureDetector(
      onTap: () async {
        try {
          RenderRepaintBoundary boundary = _globalKey[pageController.page.toInt()].currentContext.findRenderObject();
          ui.Image image = await boundary.toImage();
          ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
          var pngBytes = byteData.buffer.asUint8List();
          Share.file('esys image', 'ss32.png', pngBytes, 'image/png', text: 'My optional text.');
        } catch (e) {
          print(e);
          ToastPreset.err(context: context, str: 'Something went wrong');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30), vertical: ScreenUtil().setHeight(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: ColorTheme.primaryColor,
          border: Border.all(color: ColorTheme.primaryColor.withOpacity(0.7), width: 4),
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.share,
                color: Colors.white,
                size: ScreenUtil().setHeight(20),
              ),
              SizedBox(width: ScreenUtil().setWidth(8)),
              Text(
                'Share',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setHeight(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
