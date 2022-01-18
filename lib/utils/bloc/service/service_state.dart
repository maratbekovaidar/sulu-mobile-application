part of 'service_bloc.dart';

@immutable
abstract class ServiceState {}

class ServiceInitialState extends ServiceState {}

class ServiceLoadingState extends ServiceState {

}

class ServiceLoadedState extends ServiceState {

  final List<ServiceModel> loadedServices;
  ServiceLoadedState({required this.loadedServices});

}

class ServiceErrorState extends ServiceState {

}
