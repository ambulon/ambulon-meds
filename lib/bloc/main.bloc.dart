import 'package:flutter_bloc/flutter_bloc.dart';
import 'coupons.bloc.dart';
import 'cart.bloc.dart';
import 'home.bloc.dart';
import 'profile.bloc.dart';
import 'search.bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<HomeBloc>(create: (ctx) => HomeBloc()),
      BlocProvider<SearchBloc>(create: (ctx) => SearchBloc()),
      BlocProvider<CartBloc>(create: (ctx) => CartBloc()),
      BlocProvider<CouponsBloc>(create: (ctx) => CouponsBloc()),
      BlocProvider<ProfileBloc>(create: (ctx) => ProfileBloc()),
    ];
  }
}
