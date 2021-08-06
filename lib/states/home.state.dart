import 'package:equatable/equatable.dart';
import 'package:medcomp/models/banner.model.dart';
import 'package:medcomp/models/med.model.dart';
import 'package:medcomp/models/searchhistory.model.dart';
import 'package:medcomp/models/user.model.dart';

class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeStateNotLoaded extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateLoaded extends HomeState {
  final UserModel userModel;
  final List<BannerModel> banners;
  final List<SearchHistoryModel> searchHistory;
  final List<MedicineModel> topPicks;
  HomeStateLoaded({this.userModel, this.banners, this.searchHistory, this.topPicks});
}

class HomeStateError extends HomeState {
  final message;
  HomeStateError(this.message);
}
