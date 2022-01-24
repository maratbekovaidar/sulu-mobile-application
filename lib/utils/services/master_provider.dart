
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/utils/model/master_models/master_model.dart';


class MasterProvider {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Get Masters
  Future<List<MasterModel>> getMastersOfEstablishment(int id) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/getAllMastersOfEstablishment/$id');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.post(
          url,
          body: jsonEncode({
            "direction": "ASC",
            "pageNumber": 0,
            "pageSize": 15,
            "sortBy": "id"
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );

      /// Convert response to json list


      if (response.body.isNotEmpty) {
        List<dynamic> jsonResult = jsonDecode(
            utf8.decode(response.bodyBytes))["data"]["data"];

        return jsonResult.map((json) => MasterModel.fromJson(json)).toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Masters with Type Id
  Future<List<MasterModel>> getMastersByTypeId(int serviceTypeId, int establishmentId) async {
    var url = Uri.parse('https://sulu.azurewebsites.net/private/client/findMastersByServiceTypeIdAndEstablishmentId/$serviceTypeId/$establishmentId');

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
        return jsonResult.map((json) => MasterModel.fromJson(json)).toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

}