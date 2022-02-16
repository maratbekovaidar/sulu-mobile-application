import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/api_clients/network_client.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/master_models/master_portfolio_model.dart';


class EstablishmentProvider {


  /// Client to use get and posts
  final _networkClient = NetworkClient();

  /// Parser for getting establishments
  List<EstablishmentModel> establishmentParser(dynamic json) {
    final jsonToList=jsonDecode(utf8.decode(json.bodyBytes))["data"];
    final response = jsonToList.map<EstablishmentModel>((item)=>EstablishmentModel.fromJson(item)).toList();
    return response;
  }

  /// Parser for getting masters
  List<MasterPortfolioModel> masterPortfolioParser(dynamic json) {
    final jsonToList=jsonDecode(utf8.decode(json.bodyBytes))["data"];
    final response= jsonToList.map<MasterPortfolioModel>((item)=>MasterPortfolioModel.fromJson(item)).toList();
    return response;
  }

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();


  /**
   *  Queries and Requests
   */


  /// Get Establishments
  Future<List<EstablishmentModel>> getEstablishments() async {

    String? token = await storage.read(key: 'token');

    final Future<List<EstablishmentModel>> result = _networkClient.get(
        path: "private/client/findEstablishmentsByUserToken",
        parser: establishmentParser,
        headerParameters: {
          'Content-Type': 'application/json',
          'Authorization': token!
        }
    );

    return result;
  }

  /// Get Popular Establishments
  Future<List<EstablishmentModel>> getPopularEstablishments() async {

    String? token = await storage.read(key: 'token');

    final Future<List<EstablishmentModel>>result= _networkClient.get(path: "private/client/findAllFavoritesOfTheEstablishment",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      'Authorization': token!
    });

    return result;

  }

  /// Get Establishments with Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithFilter(int typeId) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/private/client/findEstablishments/byServiceTypeId/$typeId');
    String? token = await storage.read(key: 'token');


    final Future<List<EstablishmentModel>>result= _networkClient.get(path: "private/client/findEstablishmentByName/serviceTypeId/userToken?serviceTypeId=$typeId",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      'Authorization': token!
    });

    return result;
  }

  /// Get Establishments with name
  Future<List<EstablishmentModel>> getEstablishmentsWithName(String name) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/private/client/findByEstablishmentName/$name');
    String? token = await storage.read(key: 'token');


    final Future<List<EstablishmentModel>>result= _networkClient.get(path: "private/client/findEstablishmentByName/serviceTypeId/userToken?establishmentName=$name",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      'Authorization': token!
    });

    return result;
  }

  /// Get Establishment with name and Service Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithNameAndTypeId(String name, int typeId) async {

    String? token = await storage.read(key: 'token');

    final Future<List<EstablishmentModel>> result = _networkClient.get(path:"private/client/findEstablishmentByName/serviceTypeId/userToken?establishmentName=$name&serviceTypeId=$typeId",parser: establishmentParser,headerParameters: {
      'Authorization': token!,
      'Content-Type': 'application/json'
    });
    return result;

  }

  /// Get Establishment portfolio
  Future<List<MasterPortfolioModel>> getPortfolioOfEstablishment(int id) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/private/client/findAllPortfolioOfEstablishmentById/$id');

    String? token = await storage.read(key: 'token');


    final Future<List<MasterPortfolioModel>> result = _networkClient.get(path: "private/client/findAllPortfolioOfEstablishmentById/$id",parser: establishmentParser, headerParameters: {
      'Authorization': token!,
      'Content-Type': 'application/json'
    });
    return result;
  }

  /// Get available time
  Future<List<String>> getAvailableTimes(String date, int masterDataId) async {
    var url = Uri.parse('${Configuration.host}private/appointment/check/IsExistsInDate?date=$date&masterDataId=$masterDataId');

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

  /// Get Establishments that favorite
  Future<List<EstablishmentModel>> getFavoriteEstablishments() async {

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


}