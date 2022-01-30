import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/states/cart.state.dart';
import 'package:medcomp/utils/colortheme.dart';
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
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: Styles.getWidth(context), height: Styles.getHeight(context), allowFontScaling: true)
          ..init(context);
    return BlocConsumer<CartBloc, CartState>(
      listener: (ctx, CartState state) {},
      builder: (ctx, CartState state) {
        if (state is CartStateLoading) {
          return Loader.def();
        }
        if (state is CartStateError) {
          return ErrorPage(message: state.message);
        }
        if (state is CartStateEmpty) {
          return Scaffold(
            backgroundColor: ColorTheme.fontWhite,
            appBar: CustomAppBar.cart(context: context, empty: true),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(Styles.getHeight(context) ~/ 6),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/cartempty.png'),
                    )),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(40)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                    child: Text(
                      'Seems like you haven\'t added anyting',
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
                      'Add multiple medicines and get the results for the best prices.',
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
