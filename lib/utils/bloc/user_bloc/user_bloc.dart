import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sulu_mobile_application/utils/model/city_model/city_model.dart';
import 'package:sulu_mobile_application/utils/model/user_model.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class  UserBloc extends Bloc<UserEvent, UserState> {

  UserService provider = UserService();

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if(event is UserLoadEvent) {
        emit(UserLoadingState());
        try {
          UserModel _userModel = await provider.getLoggedUser();
          return emit(UserLoadedState(userModel: _userModel));
        } catch(e) {
          debugPrint("GetLoggedUserInfo exception: " + e.toString());
          // FlutterSecureStorage storage = const FlutterSecureStorage();
          // storage.delete(key: 'token');
          // if(e.toString() == "FormatException: Unexpected end of input (at character 1)") {
          //   FlutterSecureStorage storage = const FlutterSecureStorage();
          //   storage.delete(key: 'token');
          //   WidgetsBinding.instance!
          //       .addPostFrameCallback((_) => main());
          // }
          return emit(UserErrorState());
        }
      }
      if(event is UserLoadCitiesEvent) {
        emit(UserLoadingState());
        try {
          List<CityModel> _cities = await provider.getCities();
          return emit(UserCitiesLoadedState(cities: _cities));
        } catch(e) {
          debugPrint("GetLoggedUserInfo exception: " + e.toString());
          return emit(UserErrorState());
        }
      }
    });
  }
}
