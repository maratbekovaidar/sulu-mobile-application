

import 'package:chopper/chopper.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';

part 'banner_service.chopper.dart';


@ChopperApi()

abstract class BannerService extends ChopperService{
  static BannerService create(ChopperClient client)=> _$BannerService(client);

  //Get main banners
  @Get(path:'private/client/findAllAdvertisements')
  Future<Response> getMainBanners();
}