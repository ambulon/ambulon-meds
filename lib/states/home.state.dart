import 'package:equatable/equatable.dart';
import 'package:medcomp/models/user.model.dart';

class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeStateNotLoaded extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final UserModel userModel;
  HomeStateLoaded(this.userModel);
}

class HomeStateError extends HomeState {
  final message;
  HomeStateError(this.message);
}
