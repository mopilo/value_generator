import 'package:flutter/material.dart';

class ThemeState {
  final ThemeData? themeData;
  ThemeState({required this.themeData});
}

class HomeState {
  final int counter;
  HomeState({required this.counter});

  @override
  List<Object> get props => [counter];
}
