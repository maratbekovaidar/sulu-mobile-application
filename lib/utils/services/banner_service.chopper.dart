// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$BannerService extends BannerService {
  _$BannerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = BannerService;

  @override
  Future<Response<dynamic>> getMainBanners() {
    final $url = 'private/client/findAllAdvertisements';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
