
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class ExistsTimeRepository {

  final EstablishmentProvider _establishmentProvider = EstablishmentProvider();
  Future<List<String>> getExistsTime(String date, int masterDataId) => _establishmentProvider.getAvailableTimes(date, masterDataId);

}