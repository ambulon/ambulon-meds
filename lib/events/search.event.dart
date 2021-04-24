import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEventLoadData extends SearchEvent {
  final List strList;
  SearchEventLoadData({@required this.strList});
}

class SearchEventRemoveSearch extends SearchEvent {}
