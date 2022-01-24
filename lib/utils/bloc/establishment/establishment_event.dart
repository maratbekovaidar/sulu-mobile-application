part of 'establishment_bloc.dart';

@immutable
abstract class EstablishmentEvent {}

class EstablishmentLoadEvent extends EstablishmentEvent {

}

class EstablishmentLoadPopularEvent extends EstablishmentEvent {

}

class EstablishmentFavoriteLoadEvent extends EstablishmentEvent {

}

class EstablishmentLoadByTypeIdEvent extends EstablishmentEvent {
  final int typeId;
  EstablishmentLoadByTypeIdEvent({required this.typeId});
}

class EstablishmentLoadByNameEvent extends EstablishmentEvent {
  final String name;
  EstablishmentLoadByNameEvent({required this.name});
}

class EstablishmentLoadByNameAndTypeIdEvent extends EstablishmentEvent {
  final String name;
  final int typeId;
  EstablishmentLoadByNameAndTypeIdEvent({required this.name, required this.typeId});
}