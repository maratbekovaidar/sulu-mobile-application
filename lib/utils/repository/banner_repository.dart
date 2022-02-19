
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/services/banner_provider.dart';

class BannerRepository {

  final BannerProvider _bannerProvider = BannerProvider();

  Future<List<MainBannerModel>> getMainBanners() => _bannerProvider.getMainBanners();

}