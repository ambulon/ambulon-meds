import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/states/cart.state.dart';
import 'package:medcomp/views/cart/cart.display.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/error.dart';
import 'package:medcomp/widget_constants/loader.dart';

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
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return BlocConsumer<CartBloc, CartState>(
      listener: (ctx, CartState state) {},
      builder: (ctx, CartState state) {
        if (state is CartStateLoading) {
          return Scaffold(
            appBar: CustomAppBar.def(title: 'Your Cart', context: context),
            body: Center(
              child: Loader.medCardShimmer(),
            ),
          );
        }
        if (state is CartStateError) {
          return ErrorPage(message: state.message);
        }
        if (state is CartStateEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text('Add items'),
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
