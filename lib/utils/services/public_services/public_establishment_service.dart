import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/api_clients/network_client.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';
import 'package:sulu_mobile_application/utils/model/master_models/master_portfolio_model.dart';


class PublicEstablishmentService {


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
        path: "public/client/findEstablishmentsByUserToken",
        parser: establishmentParser,
        headerParameters: {
          'Content-Type': 'application/json',
          
        }
    );

    return result;
  }

  /// Get Popular Establishments
  Future<List<EstablishmentModel>> getPopularEstablishments() async {

    String? token = await storage.read(key: 'token');

    final Future<List<EstablishmentModel>>result= _networkClient.get(path: "public/client/findAllFavoritesOfTheEstablishment",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      
    });

    return result;

  }

  /// Get Establishments with Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithFilter(int typeId) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/public/client/findEstablishments/byServiceTypeId/$typeId');
    String? token = await storage.read(key: 'token');


    final Future<List<EstablishmentModel>>result = _networkClient.get(path: "public/client/findEstablishmentByName/serviceTypeId/userToken",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      
    },
        parameters: {
          'serviceTypeId': typeId.toString()
        }
    );

    return result;
  }

  /// Get Establishments with name
  Future<List<EstablishmentModel>> getEstablishmentsWithName(String name) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/public/client/findByEstablishmentName/$name');
    String? token = await storage.read(key: 'token');


    final Future<List<EstablishmentModel>>result= _networkClient.get(path: "public/client/findEstablishmentByName/serviceTypeId/userToken",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json',
      
    },
        parameters: {
          'establishmentName': name
        });

    return result;
  }

  /// Get Establishment with name and Service Type Id
  Future<List<EstablishmentModel>> getEstablishmentsWithNameAndTypeId(String name, int typeId) async {

    String? token = await storage.read(key: 'token');

    final Future<List<EstablishmentModel>> result = _networkClient.get(path:"public/client/findEstablishmentByName/serviceTypeId/userToken",parser: establishmentParser,headerParameters: {
      'Content-Type': 'application/json'
    },
        parameters: {
          'serviceTypeId': typeId.toString(),
          'establishmentName': name
        });
    return result;

  }

  /// Get Establishment portfolio
  Future<List<MasterPortfolioModel>> getPortfolioOfEstablishment(int id) async {
    // var url = Uri.parse(
    //     'http://94.247.129.64:8080/public/client/findAllPortfolioOfEstablishmentById/$id');

    String? token = await storage.read(key: 'token');


    final Future<List<MasterPortfolioModel>> result = _networkClient.get(path: "public/client/findAllPortfolioOfEstablishmentById/$id",parser: establishmentParser, headerParameters: {
      'Content-Type': 'application/json'
    });
    return result;
  }

  /// Get available time
  Future<List<TimeOfDay>> getAvailableTimes(String date, int masterDataId) async {


    var url = Uri.parse('${Configuration.host}public/appointment/check/IsExistsInDate?date=$date&masterDataId=$masterDataId');

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
        List<TimeOfDay> times = timesJson.map((time) {
          TimeOfDay timeOfDay = TimeOfDay(hour: int.parse(time.toString().substring(0, 2)), minute: int.parse(time.toString().substring(3, 5)));
          return timeOfDay;
        }).toList();

        double toDoubleTimeOfDay(TimeOfDay timeOfDay) {
          return timeOfDay.hour + timeOfDay.minute / 60;
        }

        times.sort(
                (a, b) {
              return toDoubleTimeOfDay(a).compareTo(toDoubleTimeOfDay(b));
            }
        );
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
        '${Configuration.host}public/favorite/get/establishments');

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