part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {

  final List<CommentModel> loadedCommentsOfEstablishment;
  CommentLoadedState({required this.loadedCommentsOfEstablishment});

}

class CommentErrorState extends CommentState {}
