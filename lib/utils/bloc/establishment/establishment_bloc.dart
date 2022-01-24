import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/master_models/master_portfolio_model.dart';
import 'package:sulu_mobile_application/utils/repository/establishment_repository.dart';

part 'establishment_event.dart';
part 'establishment_state.dart';

class EstablishmentBloc extends Bloc<EstablishmentEvent, EstablishmentState> {

  final EstablishmentRepository establishmentRepository;

  EstablishmentBloc({required this.establishmentRepository}) : super(EstablishmentInitialState()) {
    on<EstablishmentEvent>((event, emit) async {
      final List<EstablishmentModel> _establishments;

      /// Load Establishment
      if(event is EstablishmentLoadEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getEstablishments();
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      /// Load popular
      if(event is EstablishmentLoadPopularEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getPopularEstablishments();
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      /// Load Establishment by typeId
      if(event is EstablishmentLoadByTypeIdEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getEstablishmentsByTypeId(event.typeId);
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      /// Load Establishment by name
      if(event is EstablishmentLoadByNameEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getEstablishmentsByName(event.name);
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      /// Load Establishment by name and type id
      if(event is EstablishmentLoadByNameAndTypeIdEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getEstablishmentsByNameAndTypeId(event.name, event.typeId);
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      /// Load Establishment of favorite
      if(event is EstablishmentFavoriteLoadEvent) {
        emit(EstablishmentLoadingState());
        try {
          _establishments = await establishmentRepository.getFavoriteEstablishments();
          return emit(EstablishmentLoadedState(establishments: _establishments));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

      if(event is EstablishmentLoadPortfolioEvent) {
        emit(EstablishmentLoadingState());
        try {
          List<MasterPortfolioModel> _portfolio = await establishmentRepository.getPortfolioOfEstablishment(event.id);
          return emit(EstablishmentLoadedPortfolioState(loadedPortfolio: _portfolio));
        } catch(exception) {
          return emit(EstablishmentErrorState());
        }
      }

    });
  }
}
