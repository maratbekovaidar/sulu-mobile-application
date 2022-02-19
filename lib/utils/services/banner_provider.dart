
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/utils/api_clients/network_client.dart';
import 'package:sulu_mobile_application/utils/model/main_banner_model.dart';

class BannerProvider {

  /// Client to use get and posts
  final _networkClient = NetworkClient();

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  List<MainBannerModel> bannerParser(dynamic json) {
    final jsonToList=jsonDecode(utf8.decode(json.bodyBytes))["data"];
    final response = jsonToList.map<MainBannerModel>((item)=>MainBannerModel.fromJson(item)).toList();
    return response;
  }

  /// Get MainBanner
  Future<List<MainBannerModel>> getMainBanners() async {

    String? token = await storage.read(key: 'token');

    final Future<List<MainBannerModel>> result = _networkClient.get(
        path: "private/client/findAllAdvertisements",
        parser: bannerParser,
        headerParameters: {
          'Content-Type': 'application/json',
          'Authorization': token!
        }
    );

    return result;
  }

}