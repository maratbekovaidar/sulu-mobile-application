
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/master_models/master_portfolio_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_service.dart';
import 'package:sulu_mobile_application/utils/services/favorite_service.dart';

class EstablishmentRepository {

  final EstablishmentService _establishmentProvider = EstablishmentService();

  Future<List<EstablishmentModel>> getEstablishments() => _establishmentProvider.getEstablishments();

  Future<List<EstablishmentModel>> getPopularEstablishments() => _establishmentProvider.getPopularEstablishments();

  Future<List<EstablishmentModel>> getEstablishmentsByTypeId(int typeId) => _establishmentProvider.getEstablishmentsWithFilter(typeId);

  Future<List<EstablishmentModel>> getEstablishmentsByName(String name) => _establishmentProvider.getEstablishmentsWithName(name);

  Future<List<EstablishmentModel>> getEstablishmentsByNameAndTypeId(String name, int typeId) => _establishmentProvider.getEstablishmentsWithNameAndTypeId(name, typeId);

  Future<List<EstablishmentModel>> getFavoriteEstablishments() => _establishmentProvider.getFavoriteEstablishments();

  Future<List<MasterPortfolioModel>> getPortfolioOfEstablishment(int id) => _establishmentProvider.getPortfolioOfEstablishment(id);


}