
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/services/appointment_provider.dart';

class AppointmentRepository {

  final AppointmentProvider _provider = AppointmentProvider();
  Future<List<AppointmentModel>> getAppointments() => _provider.getAppointments();

}