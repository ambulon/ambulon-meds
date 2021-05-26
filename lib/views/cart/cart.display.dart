import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/models/cart.model.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/widget_constants/med_card_cart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CartDisplay extends StatefulWidget {
  final CartModel cartModel;
  CartDisplay({this.cartModel});
  @override
  _CartDisplayState createState() => _CartDisplayState();
}

class _CartDisplayState extends State<CartDisplay> {
  PageController pageController = PageController(initialPage: 0);

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
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, 0, 0),
                    child: PageView(
                      physics: BouncingScrollPhysics(),
                      controller: pageController,
                      scrollDirection: Axis.vertical,
                      children: [
                        content(title: 'Best', totalPrice: widget.cartModel.totalPrice.minPrice),
                        content(title: 'Netmeds', totalPrice: widget.cartModel.totalPrice.netmeds),
                        content(title: '1mg', totalPrice: widget.cartModel.totalPrice.i1mg),
                        content(title: 'Apollo', totalPrice: widget.cartModel.totalPrice.apollo),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1, -1),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(15), ScreenUtil().setHeight(20), 0, 0),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 4,
                        axisDirection: Axis.vertical,
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
                shareButton(),
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
    String title,
    double totalPrice,
  }) {
    return Container(
      child: SingleChildScrollView(
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
                title == 'Best' ? 'Best Price : \₹ ${totalPrice.toStringAsFixed(2)}' : 'Total Price : \₹ ${totalPrice.toStringAsFixed(2)}',
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
                name: item.name,
                quantity: item.quantity,
              ),
          ],
        ),
      ),
    );
  }

  GestureDetector clearButton() {
    return GestureDetector(
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
