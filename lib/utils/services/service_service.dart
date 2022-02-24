

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/utils/model/establishment_models/service_type_model.dart';


class ServiceService {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Get Service of Establishment
  Future<List<ServiceModel>> getServiceByEstablishmentId(int id) async {
    var url = Uri.parse(
        '${Configuration.host}private/client/findServicesOfEstablishment/byEstablishmentId/$id');

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


        return jsonResult.map((json) => ServiceModel.fromJson(json)).toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Get Service Types
  Future<List<ServiceTypeModel>> getServiceTypes() async {
    var url = Uri.parse(
        '${Configuration.host}private/type/getServiceTypes');

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


        return jsonResult.map((json) => ServiceTypeModel.fromJson(json)).toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

  /// Set Appointment
  Future<bool> setAppointment(String appointmentDate,
      String appointmentStartTime, int masterId, String phoneNumber,
      int serviceId, String username) async {
    var url = Uri.parse(
        '${Configuration.imageUploadUrl}private/appointment/create');

    String? token = await storage.read(key: 'token');


    if (token != null) {
      var response = await http.post(
          url,
          body: jsonEncode({
            "appointmentDate": appointmentDate,
            "appointmentStartTime": appointmentStartTime,
            "masterId": masterId,
            "phoneNumber": phoneNumber,
            "serviceId": serviceId,
            "username": username
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token
          }
      );


      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['httpStatus'] == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }


}