import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  CommentBloc({required this.commentRepository}) : super(CommentInitialState()) {
    on<CommentEvent>((event, emit) async {
      if(event is CommentLoadEvent) {
        emit(CommentLoadingState());
        try {
          List<CommentModel> loadedCommentsOfEstablishment = await commentRepository.getCommentOfEstablishment(event.id);
          return emit(CommentLoadedState(loadedCommentsOfEstablishment: loadedCommentsOfEstablishment));
        } catch(e) {
          return emit(CommentErrorState());
        }

      }
    });
  }
}
