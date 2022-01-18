import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/master_model.dart';
import 'package:sulu_mobile_application/utils/repository/master_repository.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  final MasterRepository masterRepository;
  MasterBloc({required this.masterRepository}) : super(MasterInitialState()) {
    on<MasterEvent>((event, emit) async {

      if(event is MasterLoadEvent) {
        emit(MasterLoadingState());
        try {
          List<MasterModel> _loadedMastersOfEstablishment = await masterRepository.getMasterOfEstablishment(event.id);
          return(emit(MasterLoadedState(loadedMastersOfEstablishment: _loadedMastersOfEstablishment)));
        } catch(e) {
          print("Master error " + e.toString());
          return(emit(MasterErrorState()));
        }
      }

      if(event is MasterLoadByTypeIdEvent) {
        emit(MasterLoadingState());
        try {
          List<MasterModel> _loadedMastersOfEstablishment = await masterRepository.getMasterByTypeId(event.id);
          return(emit(MasterLoadedState(loadedMastersOfEstablishment: _loadedMastersOfEstablishment)));
        } catch(e) {
          print("Master error " + e.toString());
          return(emit(MasterErrorState()));
        }
      }


    });
  }


}
