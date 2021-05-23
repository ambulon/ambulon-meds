import 'package:equatable/equatable.dart';

class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CartEventLoadFromPrefs extends CartEvent {}

class CartEventEditList extends CartEvent {}

class CartEventClearData extends CartEvent {}

class CartEventLoadNetworkData extends CartEvent {
  final List list;
  CartEventLoadNetworkData(this.list);
}
