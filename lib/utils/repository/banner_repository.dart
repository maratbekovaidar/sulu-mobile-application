
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';
import 'package:sulu_mobile_application/utils/services/banner_service.dart';

class BannerRepository {

  // final BannerService _bannerProvider = BannerService();

  Future<Request> authHeaderInterceptor(Request request)async{
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    final Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Authorization': token!
          };
    request = request.copyWith(headers: headers);
    return request;
  }

  BannerService get service => BannerService.create(
  ChopperClient(
      baseUrl: Configuration.host,
     interceptors: [
     authHeaderInterceptor
      ],
    converter: const JsonConverter()
   ));

  Future<List<MainBannerModel>> getMainBanners() async {
    final Response response=await service.getMainBanners();
    List<MainBannerModel> banners= jsonDecode(response.bodyString)["data"].map<MainBannerModel>
      ((item)=>MainBannerModel.fromJson(item)).toList();
    return banners;
  }

}
// GetIt.I.registerLazySingleton(() => BannerService.create(
// ChopperClient(baseUrl: Configuration.host,
// interceptors: [
// authHeaderInterceptor
// ],
// converter: const JsonConverter()
// )))