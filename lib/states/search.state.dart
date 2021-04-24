import 'package:equatable/equatable.dart';
import 'package:medcomp/models/search.model.dart';

class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStateNotLoaded extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateLoaded extends SearchState {
  final SearchModel searchModel;
  SearchStateLoaded(this.searchModel);
}

class SearchStateError extends SearchState {
  final message;
  SearchStateError(this.message);
}
