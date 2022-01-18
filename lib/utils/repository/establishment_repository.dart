
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class EstablishmentRepository {

  final EstablishmentProvider _establishmentProvider = EstablishmentProvider();
  Future<List<EstablishmentModel>> getEstablishments() => _establishmentProvider.getEstablishments();

  Future<List<EstablishmentModel>> getEstablishmentsByTypeId(int typeId) => _establishmentProvider.getEstablishmentsWithFilter(typeId);

  Future<List<EstablishmentModel>> getEstablishmentsByName(String name) => _establishmentProvider.getEstablishmentsWithName(name);

  Future<List<EstablishmentModel>> getFavoriteEstablishments() => _establishmentProvider.getFavoriteEstablishments();


}