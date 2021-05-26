import 'package:equatable/equatable.dart';
import 'package:medcomp/models/cart.model.dart';

class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartStateNotLoaded extends CartState {}

class CartStateLoading extends CartState {}

class CartStateLoadedData extends CartState {
  final CartModel model;
  CartStateLoadedData(this.model);
}

class CartStateEmpty extends CartState {}

class CartStateError extends CartState {
  final message;
  CartStateError(this.message);
}
