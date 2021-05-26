import 'package:equatable/equatable.dart';

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

class CartEventUpdateQuantity extends CartEvent {}
