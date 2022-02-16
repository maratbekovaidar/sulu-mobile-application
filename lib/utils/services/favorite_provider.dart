import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';

class FavoriteProvider{

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();


  /// Get Establishments ids that favorite
  Future<List<int>> getFavoriteEstablishments() async {

    var url = Uri.parse(
        '${Configuration.host}private/favorite/get/establishments');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      /// Convert response to json list
      if (response.body.isNotEmpty) {
        List<dynamic> jsonResult = jsonDecode(
            utf8.decode(response.bodyBytes))["data"];
        List<EstablishmentModel> favEst= jsonResult.map((json) => EstablishmentModel.fromJson(json["establishmentDTO"]))
            .toList();
        return favEst.map((e) => e.id).toList();

      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }

  }

  /// Favorite status
  Future<bool> getFavoriteStatus(int id) async{
    List<int> favEsts = await getFavoriteEstablishments();
    if (favEsts.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  /// Remove Favorite Establishment
  Future<int> removeFavoriteEstablishment(int id) async {

    var url = Uri.parse(
        '${Configuration.host}private/favorite/deleteEstablishmentBy/$id');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.delete(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      /// Convert response to json list
      if (response.body.isNotEmpty) {
        int statusCode = jsonDecode(response.body)['httpStatus'];
        return statusCode;
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Set Favorite Establishment
  Future<int> setFavoriteEstablishment(int id) async {

    var url = Uri.parse(
        '${Configuration.host}private/favorite/addEstablishment/$id');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      /// Convert response to json list
      if (response.body.isNotEmpty) {
        int statusCode = jsonDecode(response.body)['httpStatus'];
        return statusCode;
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

}