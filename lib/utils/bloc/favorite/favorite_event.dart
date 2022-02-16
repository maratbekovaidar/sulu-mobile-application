part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {

}
class FavoriteLoadingEvent extends FavoriteEvent{}

class FavoriteInitialEvent extends FavoriteEvent{}

class FavoriteLoadEvent extends FavoriteEvent{
  final int branchId;
  FavoriteLoadEvent(this.branchId);
}

class FavoriteSetEvent extends FavoriteEvent{
  final BuildContext context;
  final int branchId;
  FavoriteSetEvent({required this.branchId,required this.context});
}
