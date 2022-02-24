part of 'exists_time_bloc.dart';

@immutable
abstract class ExistsTimeState {}

class ExistsTimeInitialState extends ExistsTimeState {}

class ExistsTimeLoadingState extends ExistsTimeState {}

class ExistsTimeLoadedState extends ExistsTimeState {

  final List<TimeOfDay> loadedExistsTime;
  ExistsTimeLoadedState({required this.loadedExistsTime});

}

class ExistsTimeErrorState extends ExistsTimeState {}
