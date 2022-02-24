
import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/utils/services/establishment_service.dart';

class ExistsTimeRepository {

  final EstablishmentService _establishmentProvider = EstablishmentService();
  Future<List<TimeOfDay>> getExistsTime(String date, int masterDataId) => _establishmentProvider.getAvailableTimes(date, masterDataId);

}