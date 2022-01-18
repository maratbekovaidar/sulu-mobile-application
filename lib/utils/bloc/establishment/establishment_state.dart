part of 'establishment_bloc.dart';

@immutable
abstract class EstablishmentState {}

class EstablishmentInitialState extends EstablishmentState {}

class EstablishmentLoadingState extends EstablishmentState {}

class EstablishmentLoadedState extends EstablishmentState {

  final List<EstablishmentModel> establishments;
  EstablishmentLoadedState({required this.establishments});

}

class EstablishmentErrorState extends EstablishmentState {

}
