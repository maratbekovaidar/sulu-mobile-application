
import 'package:sulu_mobile_application/utils/model/establishment_models/master_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class MasterRepository {
  final EstablishmentProvider _provider = EstablishmentProvider();
  Future<List<MasterModel>> getMasterOfEstablishment(int id) => _provider.getMastersOfEstablishment(id);
  Future<List<MasterModel>> getMasterByTypeId(int serviceTypeId, int establishmentId) => _provider.getMastersByTypeId(serviceTypeId, establishmentId);
}