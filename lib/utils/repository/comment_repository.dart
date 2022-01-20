
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class CommentRepository {

  final EstablishmentProvider _establishmentProvider = EstablishmentProvider();
  Future<List<CommentModel>> getCommentOfEstablishment(int id) => _establishmentProvider.getCommentsOfEstablishment(id);

}