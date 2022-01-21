part of 'exists_time_bloc.dart';

@immutable
abstract class ExistsTimeEvent {}

class ExistsTimeLoadEvent extends ExistsTimeEvent {

  final String date;
  final int masterDataId;
  ExistsTimeLoadEvent({required this.date, required this.masterDataId});

}