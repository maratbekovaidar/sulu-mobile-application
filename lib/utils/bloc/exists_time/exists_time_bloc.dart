import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exists_time_event.dart';
part 'exists_time_state.dart';

class ExistsTimeBloc extends Bloc<ExistsTimeEvent, ExistsTimeState> {
  ExistsTimeBloc() : super(ExistsTimeInitial()) {
    on<ExistsTimeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
