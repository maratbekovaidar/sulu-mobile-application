part of 'master_bloc.dart';

@immutable
abstract class MasterEvent {}

class MasterLoadEvent extends MasterEvent {
  final int id;
  MasterLoadEvent({required this.id});
}


class MasterLoadByTypeIdEvent extends MasterEvent {
  final int id;
  MasterLoadByTypeIdEvent({required this.id});
}