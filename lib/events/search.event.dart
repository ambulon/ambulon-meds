import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medcomp/models/med.model.dart';

class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEventLoadData extends SearchEvent {
  final List strList;
  final List<MedicineModel> dataList;
  SearchEventLoadData({@required this.strList, @required this.dataList});
}

class SearchEventRemoveSearch extends SearchEvent {}
