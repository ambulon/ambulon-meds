import 'package:bloc/bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/repositories/cart.repo.dart';
import 'package:medcomp/states/cart.state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => CartStateNotLoaded();

  CartRepo _cartRepo = CartRepo();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartEventLoad) {
      yield CartStateLoading();
      try {
        var res = await this._cartRepo.getData();
        if (res == null) {
          yield CartStateEmpty();
        } else {
          yield CartStateLoadedData(res);
        }
      } catch (e) {
        yield CartStateError(e);
      }
    }

    if (event is CartEventClearCart) {
      try {
        yield CartStateLoading();
        var res = await this._cartRepo.clear();
        if (res) {
          yield CartStateEmpty();
        } else {
          yield CartStateError('error in clear cart maptoState');
        }
      } catch (e) {
        yield CartStateError(e);
      }
    }
  }
}
