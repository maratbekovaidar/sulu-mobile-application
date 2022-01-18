part of 'appointment_bloc.dart';

@immutable
abstract class AppointmentState {}

class AppointmentInitialState extends AppointmentState {}

class AppointmentLoadingState extends AppointmentState {}

class AppointmentLoadedState extends AppointmentState {

  final List<AppointmentModel> loadedAppointments;
  AppointmentLoadedState({required this.loadedAppointments});

}

class AppointmentErrorState extends AppointmentState {}
