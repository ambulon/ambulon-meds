import 'package:equatable/equatable.dart';
import 'package:medcomp/models/user.model.dart';

class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileStateNotLoaded extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateLoaded extends ProfileState {
  final UserModel user;
  ProfileStateLoaded({this.user});
}

class ProfileStateError extends ProfileState {
  final message;
  ProfileStateError(this.message);
}
