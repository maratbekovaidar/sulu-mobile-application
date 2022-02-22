part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}
class CityLoadingState extends CityState {}
class CityLoadedState extends CityState {
  final List<CityModel> cities;
  CityLoadedState({required this.cities});
}
class CityErrorState extends CityState {
  }
