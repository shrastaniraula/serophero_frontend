part of 'directories_bloc.dart';

abstract class BusinessState {}

final class DirectoriesInitial extends BusinessState {}

final class DirectoriesLoading extends BusinessState {}

final class DirectoriesSuccess extends BusinessState {
  final List<DirectoriesModel> directorieslist;

  DirectoriesSuccess({required this.directorieslist});
}

final class DirectoriesFailure extends BusinessState {
  final String error;

  DirectoriesFailure({required this.error});
}

final class TokenExpired extends BusinessState {}
