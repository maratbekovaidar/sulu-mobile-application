
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/services/appointment_service.dart';

class AppointmentRepository {

  final AppointmentService _provider = AppointmentService();
  Future<List<AppointmentModel>> getAppointments() => _provider.getAppointments();

}