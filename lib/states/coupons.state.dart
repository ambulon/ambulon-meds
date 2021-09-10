import 'package:equatable/equatable.dart';
import 'package:medcomp/models/coupons.model.dart';

class CouponsState extends Equatable {
  @override
  List<Object> get props => [];
}

class CouponsStateNotLoaded extends CouponsState {}

class CouponsStateLoading extends CouponsState {}

class CouponsStateLoaded extends CouponsState {
  final List<CouponsModel> result;
  CouponsStateLoaded({this.result});
}

class CouponsStateError extends CouponsState {
  final message;
  CouponsStateError(this.message);
}
