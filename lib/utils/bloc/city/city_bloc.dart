import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/bloc/user_bloc/user_bloc.dart';
import 'package:sulu_mobile_application/utils/model/city_model/city_model.dart';
import 'package:sulu_mobile_application/utils/services/user_service.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  UserService provider = UserService();

  CityBloc() : super(CityInitial()) {
    on<CityEvent>((event, emit) async {

      if(event is CityLoadEvent) {
        emit(CityLoadingState());
        try {
          List<CityModel> _cities = await provider.getCities();
          return emit(CityLoadedState(cities: _cities));
        } catch(e) {
          debugPrint("GetLoggedUserInfo exception: " + e.toString());
          return emit(CityErrorState());
        }
      }
    });

  }
}
