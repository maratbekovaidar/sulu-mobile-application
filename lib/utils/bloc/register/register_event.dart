part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class ToRegisterEvent extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String patronymic;
  final String phoneNumber;
  final String password;

  ToRegisterEvent({required this.firstName, required this.lastName, required this.patronymic,
      required this.phoneNumber, required this.password});

}