import 'package:equatable/equatable.dart';

class HomeMedState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeMedStateNotLoaded extends HomeMedState {}

class HomeMedStateLoading extends HomeMedState {}

class HomeMedStateLoaded extends HomeMedState {
  // final MedicineModel model;
  // HomeMedStateLoaded(this.model);
}

class HomeMedStateError extends HomeMedState {}
