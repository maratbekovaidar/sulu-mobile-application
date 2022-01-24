import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';


class EstablishmentProvider {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Get Establishments
  Future<List<EstablishmentModel>> getEstablishments() async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/findAll/establishments');

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
        return jsonResult.map((json) => EstablishmentModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Popular Establishments
  Future<List<EstablishmentModel>> getPopularEstablishments() async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/findAllFavoritesOfTheEstablishment');

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
        return jsonResult.map((json) => EstablishmentModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Establishments with Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithFilter(int typeId) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/findEstablishments/byServiceTypeId/$typeId');

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
        return jsonResult.map((json) => EstablishmentModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Establishments with name
  Future<List<EstablishmentModel>> getEstablishmentsWithName(String name) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/findByEstablishmentName/$name');

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
        return jsonResult.map((json) => EstablishmentModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Establishment with name and Service Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithNameAndTypeId(String name, int typeId) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/getEstablishmentByNameAndServiceTypeId?establishmentName=$name&serviceTypeId=$typeId');

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
        return jsonResult.map((json) => EstablishmentModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Establishments that favorite
  Future<List<EstablishmentModel>> getFavoriteEstablishments() async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/favorite/get/establishments');

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
            return jsonResult.map((json) => EstablishmentModel.fromJson(json["establishmentDTO"]))
            .toList();
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
        'https://sulu.azurewebsites.net/private/favorite/addEstablishment/$id');

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

  /// Remove Favorite Establishment
  Future<int> removeFavoriteEstablishment(int id) async {

    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/favorite/deleteEstablishmentBy/$id');

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

  /// Get available time
  Future<List<String>> getAvailableTimes(String date, int masterDataId) async {
    var url = Uri.parse('https://sulu.azurewebsites.net/private/appointment/check/IsExistsInDate?date=$date&masterDataId=$masterDataId');

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
        dynamic jsonResult = jsonDecode(
            utf8.decode(response.bodyBytes))["data"];
        List<dynamic> timesJson = jsonResult["availableTimes"];
        List<String> times = timesJson.map((e) => e.toString()).toList();
        return times;
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }


  }

}