part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentLoadEvent extends CommentEvent {

  final int id;
  CommentLoadEvent({required this.id});

}