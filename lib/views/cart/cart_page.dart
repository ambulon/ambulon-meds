import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medcomp/bloc/cart.bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/states/cart.state.dart';
import 'package:medcomp/widget_constants/custom_appbar.dart';
import 'package:medcomp/utils/styles.dart';
import 'package:medcomp/widget_constants/error.dart';
import 'package:medcomp/widget_constants/loader.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List initList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartEventLoadFromPrefs());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: Styles.get_width(context), height: Styles.get_height(context), allowFontScaling: true)
      ..init(context);
    return Scaffold(
      appBar: CustomAppBar.def(title: 'Your Cart', context: context),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (ctx, CartState state) {},
        builder: (ctx, CartState state) {
          if (state is CartStateLoading) {
            return Loader.medCardShimmer();
          }
          if (state is CartStateError) {
            return ErrorPage(message: state.message);
          }
          if (state is CartStateInit) {
            initList = state.list;
            return initWidet(state.list);
          }
          if (state is CartStateLoadedData) {
            initList = [];
            return Text('loaded');
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget initWidet(List list) {
    return Container(
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(10)),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // TODO : show search query
                  setState(() {
                    initList.add('ssd ${DateTime.now().toString()}');
                  });
                  print(initList);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(12),
                    vertical: ScreenUtil().setHeight(7),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.teal[900],
                  ),
                  child: Text(
                    '+ ADD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setHeight(14),
                    ),
                  ),
                ),
              ),
            ),
            for (var item in initList.reversed)
              Dismissible(
                direction: DismissDirection.endToStart,
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(50),
                      alignment: Alignment.centerLeft,
                      child: Text(item),
                    ),
                  ],
                ),
                onDismissed: (direction) {
                  setState(() {
                    initList.removeAt(initList.indexOf(item));
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed')));
                },
                key: Key(item),
              ),
            // ListView.separated(
            //   itemCount: initList.length,
            //   reverse: true,
            //   separatorBuilder: (context, index) => Divider(),
            //   itemBuilder: (context, index) {
            //     final item = initList[index];

            //     return Dismissible(
            //       direction: DismissDirection.endToStart,
            //       child: Text(item),
            //       onDismissed: (direction) {
            //         setState(() {
            //           initList.removeAt(index);
            //         });
            //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed')));
            //       },
            //       key: item,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
          vertical: ScreenUtil().setHeight(7),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
