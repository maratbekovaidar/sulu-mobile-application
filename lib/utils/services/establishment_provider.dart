import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/master_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/service_model.dart';


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

  /// ***SERVICES*** ///

  /// Get Service of Establishment
  Future<List<ServiceModel>> getServiceByEstablishmentId(int id) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/client/findServicesOfEstablishment/byEstablishmentId/$id');

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

  /// Set Appointment
  Future<bool> setAppointment(String appointmentDate,
      String appointmentStartTime, int masterId, String phoneNumber,
      int serviceId, String username) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/appointment/create');

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

  /// Get Appointments
  Future<List<AppointmentModel>> getAppointments() async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/appointment/findAll');

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
        return jsonResult.map((json) => AppointmentModel.fromJson(json)).toList();
      } else {
        throw Exception("Response is null. Response status: " +
            response.statusCode.toString());
      }
    } else {
      throw Exception("Null Token. User Unauthorized");
    }
  }

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

  /// Set Comment
  Future<bool> setCommentService(int establishmentId, int masterDataId, double star, String comment) async {
    var url = Uri.parse(
        'https://sulu.azurewebsites.net/private/comment/add/feedbackToEstablishment');

    String? token = await storage.read(key: 'token');

    if (token != null) {
      var response = await http.post(
          url,
          body: jsonEncode({
            "establishmentId" : establishmentId,
            "masterDataId" : masterDataId,
            "stars" : star,
            "text" : comment
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

  /// Get Comments
  Future<List<CommentModel>> getCommentsOfEstablishment(int id) async {
    var url = Uri.parse('https://sulu.azurewebsites.net/private/comment/findAll/feedbackOfEstablishmentBy/$id');

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
        return jsonResult.map((json) => CommentModel.fromJson(json)).toList();
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

    print(date + " " + masterDataId.toString());
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
        print(jsonResult);
        List<dynamic> timesJson = jsonResult["availableTimes"];
        List<String> times = timesJson.map((e) => e.toString()).toList();
        print(times);
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