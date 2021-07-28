import 'package:equatable/equatable.dart';
import 'package:medcomp/models/cart.model.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartEventLoad extends CartEvent {}

// class CartEventRemoveItem extends CartEvent {
//   final String name;
//   CartEventRemoveItem(this.name);
// }

class CartEventClearCart extends CartEvent {}

class CartEventUpdateQuantity extends CartEvent {
  final Items updatedItem;
  CartEventUpdateQuantity(this.updatedItem);
}
