import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:sulu_mobile_application/utils/repository/service_repository.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {

  final ServiceRepository serviceRepository;

  ServiceBloc({required this.serviceRepository}) : super(ServiceInitialState()) {
    on<ServiceEvent>((event, emit) async {
      if(event is ServiceLoadEvent) {
        emit(ServiceLoadingState());
        try {
          List<ServiceModel> services = await serviceRepository.getServices(
              event.id);
          return emit(ServiceLoadedState(loadedServices: services));
        } catch (e) {
          return emit(ServiceErrorState());
        }
      }
    });
  }
}
