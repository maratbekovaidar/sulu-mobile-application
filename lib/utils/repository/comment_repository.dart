
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/services/appointment_provider.dart';

class CommentRepository {

  final AppointmentProvider _provider = AppointmentProvider();
  Future<List<CommentModel>> getCommentOfEstablishment(int id) => _provider.getCommentsOfEstablishment(id);

}