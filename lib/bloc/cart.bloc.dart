import 'package:bloc/bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/states/cart.state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartStateNotLoaded();

  CartRepo _cartRepo = CartRepo();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartEventLoadFromPrefs) {
      yield CartStateLoading();
      try {
        var res = await this._cartRepo.getPrefsData();
        if (res == null) {
          yield CartStateInit([]);
        } else {
          yield CartStateLoadedData(res);
        }
      } catch (e) {
        // TODO : remove error and put init
        yield CartStateError(e);
      }
    }

    if (event is CartEventLoadNetworkData) {
      yield CartStateLoading();
      try {
        var res = await this._cartRepo.getNetworkData(event.list);
        yield CartStateLoadedData(res);
      } catch (e) {
        yield CartStateError(e);
      }
    }

    if (event is CartEventEditList) {
      if (state is CartStateLoadedData) {
        // TODO : get list here
        List list = [];
        yield CartStateLoading();
        yield CartStateInit(list);
      } else {
        yield CartStateError('cant get the list');
      }
    }

    if (event is CartEventClearData) {
      try {
        yield CartStateLoading();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('cartPref');
        yield CartStateInit([]);
      } catch (e) {
        // TODO : remove error and put init
        yield CartStateError('cart event clear data');
      }
    }
  }
}
