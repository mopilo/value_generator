import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


class SplashCubit extends Cubit<SplashState> {

  SplashCubit() : super(SplashInitialState()) {
    _checkAuthorization();
  }

  Future<void> _checkAuthorization() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashAuthorizedState());
  }
}

@immutable
abstract class SplashState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashInitialState extends SplashState {}

class SplashUnauthorizedState extends SplashState {}

class SplashAuthorizedState extends SplashState {}
