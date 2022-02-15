part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoad extends FavoriteState {
  final bool isFavorite;


  FavoriteLoad(this.isFavorite);
}
class FavoriteLoading extends FavoriteState {

}
class FavoriteError extends FavoriteState {

}
class FavoriteSet extends FavoriteState {
  final String result;

  FavoriteSet(this.result);
}


