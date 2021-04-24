import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.bloc.dart';
import 'search.bloc.dart';

class MainBloc {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<HomeBloc>(create: (ctx) => HomeBloc()),
      BlocProvider<SearchBloc>(create: (ctx) => SearchBloc()),
    ];
  }
}
