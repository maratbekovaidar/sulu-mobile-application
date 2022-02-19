part of 'main_banner_bloc.dart';

@immutable
abstract class MainBannerState {}

class MainBannerInitialState extends MainBannerState {}

class MainBannerLoadingState extends MainBannerState {}

class MainBannerLoadedState extends MainBannerState {

  final List<MainBannerModel> loadedMainBanners;
  MainBannerLoadedState({required this.loadedMainBanners});

}

class MainBannerErrorState extends MainBannerState {}


