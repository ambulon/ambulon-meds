import 'package:equatable/equatable.dart';
import 'package:medcomp/models/search.model.dart';

class HomeMedState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeMedStateNotLoaded extends HomeMedState {}

class HomeMedStateLoading extends HomeMedState {}

class HomeMedStateLoaded extends HomeMedState {
  final SingleSearchResultModel model;
  HomeMedStateLoaded(this.model);
}

class HomeMedStateError extends HomeMedState {}
