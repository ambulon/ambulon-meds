import 'package:bloc/bloc.dart';
import 'package:medcomp/events/cart.event.dart';
import 'package:medcomp/models/cart.model.dart';
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

    if (event is CartEventUpdateQuantity) {
      CartModel model = (state as CartStateLoadedData).model;
      yield CartStateLoading();
      try {
        var data = {"cart": []};
        for (Items i in model.items) {
          if (i.id == event.updatedItem.id) {
            data["cart"].add(
              {
                "medicineId": event.updatedItem.id,
                "quantity": event.updatedItem.quantity,
              },
            );
          } else {
            data["cart"].add(
              {
                "medicineId": i.id,
                "quantity": i.quantity,
              },
            );
          }
        }
        print(data);
        bool postRes = await this._cartRepo.updateQuantity(data);
        if (postRes != null && postRes == true) {
          var res = await this._cartRepo.getData();
          if (res == null) {
            yield CartStateEmpty();
          } else {
            yield CartStateLoadedData(res);
          }
        } else {
          yield CartStateError("cant update");
        }
      } catch (e) {
        yield CartStateError(e);
      }
    }
  }
}
