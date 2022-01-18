part of 'service_bloc.dart';

@immutable
abstract class ServiceEvent {}


class ServiceLoadEvent extends ServiceEvent {

  final int id;
  ServiceLoadEvent({required this.id});

}
