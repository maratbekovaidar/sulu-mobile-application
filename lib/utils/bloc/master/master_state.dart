part of 'master_bloc.dart';

@immutable
abstract class MasterState {}

class MasterInitialState extends MasterState {}

class MasterLoadingState extends MasterState {}

class MasterLoadedState extends MasterState {

  final List<MasterModel> loadedMastersOfEstablishment;
  MasterLoadedState({required this.loadedMastersOfEstablishment});

}

class MasterErrorState extends MasterState {}
