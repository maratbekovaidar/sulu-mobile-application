
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class ServiceRepository {

  final EstablishmentProvider _provider = EstablishmentProvider();

  Future<List<ServiceModel>> getServices(int id) => _provider.getServiceByEstablishmentId(id);

}