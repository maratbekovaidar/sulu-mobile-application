part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterLoadedState extends RegisterState {
  final int status;

  RegisterLoadedState({required this.status});
}

class RegisterErrorState extends RegisterState {}
