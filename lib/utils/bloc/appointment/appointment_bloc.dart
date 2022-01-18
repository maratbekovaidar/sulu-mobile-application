import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/repository/appointment_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;
  AppointmentBloc({required this.appointmentRepository}) : super(AppointmentInitialState()) {
    on<AppointmentEvent>((event, emit) async {
      if(event is AppointmentLoadEvent) {
        emit(AppointmentLoadingState());
        try {
          List<AppointmentModel> loadedAppointments = await appointmentRepository.getAppointments();
          return emit(AppointmentLoadedState(loadedAppointments: loadedAppointments));
        } catch(e) {
          print(e.toString());
          return emit(AppointmentErrorState());
        }
      }
    });
  }
}
