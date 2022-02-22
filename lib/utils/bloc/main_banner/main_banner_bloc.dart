import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:sulu_mobile_application/utils/bloc/master/master_bloc.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/repository/banner_repository.dart';

part 'main_banner_event.dart';
part 'main_banner_state.dart';

class MainBannerBloc extends Bloc<MainBannerEvent, MainBannerState> {

  final BannerRepository bannerRepository;

  MainBannerBloc({required this.bannerRepository}) : super(MainBannerInitialState()) {
    on<MainBannerEvent>((event, emit) async {
      if(event is MainBannerLoadEvent) {
        emit(MainBannerLoadingState());
        try {
          List<MainBannerModel> _loadedMainBanners = await bannerRepository.getMainBanners();
          return emit(MainBannerLoadedState(loadedMainBanners: _loadedMainBanners));
        } catch(e) {
          print(e);
          return emit(MainBannerErrorState());
        }
      }
    });
  }
}
