import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/states/cart.state.dart';
import 'package:medcomp/views/cart/cart.display.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/constants/error.dart';
import 'package:medcomp/constants/loader.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartEventLoad());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
          ..init(context);
    return BlocConsumer<CartBloc, CartState>(
      listener: (ctx, CartState state) {},
      builder: (ctx, CartState state) {
        if (state is CartStateLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.cart(context: context, empty: true),
            body: Column(
              children: [
                Loader.medCardShimmer(),
                Loader.medCardShimmer(),
                Spacer(),
              ],
            ),
          );
        }
        if (state is CartStateError) {
          return ErrorPage(message: state.message);
        }
        if (state is CartStateEmpty) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar.cart(context: context, empty: true),
            body: Column(
              children: [
                Spacer(),
                Container(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(Styles.get_height(context) ~/ 4),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/cartempty.png'),
                  )),
                ),
                SizedBox(height: ScreenUtil().setHeight(35)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                  child: Text(
                    'Seems like you haven\'t added anyting in your cart.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setHeight(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                  child: Text(
                    'Add multiple medicines and compare to get the prices.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: ScreenUtil().setHeight(15),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(50)),
                Spacer(),
              ],
            ),
          );
        }
        if (state is CartStateLoadedData) {
          return CartDisplay(cartModel: state.model);
        }
        return SizedBox();
      },
    );
  }
}
