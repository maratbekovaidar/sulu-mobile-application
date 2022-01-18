import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/main.dart';
import 'package:sulu_mobile_application/utils/model/user_model.dart';
import 'package:sulu_mobile_application/utils/services/user_provider.dart';

part 'user_event.dart';
part 'user_state.dart';

class  UserBloc extends Bloc<UserEvent, UserState> {

  UserProvider provider = UserProvider();

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
    });
  }
}
