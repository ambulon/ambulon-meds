import 'package:equatable/equatable.dart';
import 'package:medcomp/models/cartitem.model.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartEventLoad extends CartEvent {}

class CartEventClearCart extends CartEvent {}

class CartEventUpdateQuantity extends CartEvent {
  final Item updatedItem;
  CartEventUpdateQuantity(this.updatedItem);
}
