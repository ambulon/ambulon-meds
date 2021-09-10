import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcomp/bloc/coupons.bloc.dart';
import 'cart.bloc.dart';
import 'home.bloc.dart';
import 'homemed.bloc.dart';
import 'search.bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<HomeBloc>(create: (ctx) => HomeBloc()),
      BlocProvider<SearchBloc>(create: (ctx) => SearchBloc()),
      BlocProvider<HomeMedBloc>(create: (ctx) => HomeMedBloc()),
      BlocProvider<CartBloc>(create: (ctx) => CartBloc()),
      BlocProvider<CouponsBloc>(create: (ctx) => CouponsBloc()),
    ];
  }
}
