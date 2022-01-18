import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/services/user_provider.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  UserProvider restApiProvider = UserProvider();

  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterEvent>((event, emit) async {
      if(event is ToRegisterEvent) {
        emit(RegisterLoadingState());
        try {
          int status = await restApiProvider.register(event.firstName, event.lastName, event.patronymic, event.phoneNumber, event.password);
          return emit(RegisterLoadedState(status: status));
        } catch(e) {
          return emit(RegisterErrorState());
        }
      }
    });
  }
}
