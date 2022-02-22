
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/services/service_service.dart';

class ServiceRepository {

  final ServiceService _provider = ServiceService();

  Future<List<ServiceModel>> getServices(int id) => _provider.getServiceByEstablishmentId(id);

}