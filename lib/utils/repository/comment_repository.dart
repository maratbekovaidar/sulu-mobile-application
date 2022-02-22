
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/services/appointment_service.dart';

class CommentRepository {

  final AppointmentService _provider = AppointmentService();
  Future<List<CommentModel>> getCommentOfEstablishment(int id) => _provider.getCommentsOfEstablishment(id);

}