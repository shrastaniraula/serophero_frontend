part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel homeData;
  HomeSuccess({required this.homeData});
}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure({required this.error});
}

class TokenExpired extends HomeState {}
