
import 'package:sulu_mobile_application/utils/model/master_models/master_model.dart';
import 'package:sulu_mobile_application/utils/services/master_service.dart';

class MasterRepository {
  final MasterService _provider = MasterService();
  Future<List<MasterModel>> getMasterOfEstablishment(int id) => _provider.getMastersOfEstablishment(id);
  Future<List<MasterModel>> getMasterByTypeId(int serviceTypeId, int establishmentId) => _provider.getMastersByTypeId(serviceTypeId, establishmentId);
}