
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/services/service_provider.dart';

class ServiceRepository {

  final ServiceProvider _provider = ServiceProvider();

  Future<List<ServiceModel>> getServices(int id) => _provider.getServiceByEstablishmentId(id);

}