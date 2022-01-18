
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/services/establishment_provider.dart';

class AppointmentRepository {

  EstablishmentProvider establishmentProvider = EstablishmentProvider();
  Future<List<AppointmentModel>> getAppointments() => establishmentProvider.getAppointments();

}