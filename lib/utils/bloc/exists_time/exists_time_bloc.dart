
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sulu_mobile_application/utils/repository/exists_time_repository.dart';

part 'exists_time_event.dart';
part 'exists_time_state.dart';

class ExistsTimeBloc extends Bloc<ExistsTimeEvent, ExistsTimeState> {
  final ExistsTimeRepository existsTimeRepository;
  ExistsTimeBloc({required this.existsTimeRepository}) : super(ExistsTimeInitialState()) {
    on<ExistsTimeEvent>((event, emit) async {
      if(event is ExistsTimeLoadEvent) {
        emit(ExistsTimeLoadingState());
        try {
          List<TimeOfDay> loadedExistsTime = await existsTimeRepository.getExistsTime(event.date, event.masterDataId);
          return emit(ExistsTimeLoadedState(loadedExistsTime: loadedExistsTime));
        } catch(e) {
          return emit(ExistsTimeErrorState());
        }
      }
    });
  }
}
