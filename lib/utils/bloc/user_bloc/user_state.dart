part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  UserModel userModel;

  UserLoadedState({required this.userModel});
}

class UserErrorState extends UserState {}
