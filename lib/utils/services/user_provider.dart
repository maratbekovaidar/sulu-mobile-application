import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/model/user_model.dart';

class UserProvider {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();


  /// Login query
  Future<bool> login(String username, String password) async {
      var url = Uri.parse('http://94.247.129.64:8080/public/auth/login');

      var response = await http.post(
          url,
          body: jsonEncode({
            "password": password,
            "phoneNumber": username
          }),
          headers: {
            'Content-Type':'application/json'
          }
      );

      FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

      String token;

      if(response.statusCode == 200) {
        token = jsonDecode(response.body)["data"];
        flutterSecureStorage.write(key: 'token', value: token);
        return true;
      } else {
        throw Exception("Error incorrect password or login");
      }

  }

  /// Get info about logged user
  Future<UserModel> getLoggedUser() async {
    String token;
    // try {
      token = (await storage.read(key: 'token'))!;
      var url = Uri.parse('https://sulu.azurewebsites.net/private/client/getLoggedUserInfo');

      // try {
        var response = await http.get(
            url,
            headers: {
              'Content-Type':'application/json',
              'Authorization': token
            }
        );

        return UserModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))["data"]);

        /// Exception with response
      // } catch(e) {
      //   debugPrint("GetLoggedUserInfo exception in response data " + e.toString());
      // }

      /// Exception with token
    // } catch(e) {
    //   debugPrint("GetLoggedUserInfo exception in getting token: " + e.toString());
    // }

  }

  /// Register
  Future<int> register(String firstName, String lastName, String patronymic, String phoneNumber, String password) async {
    var url = Uri.parse('${Configuration.host}public/auth/register');


    var response = await http.post(
        url,
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "password": password,
          "patronymic": "",
          "phoneNumber": phoneNumber,
          "photo": ""
        }),
        headers: {
          'Content-Type':'application/json'
        }
    );


    return response.statusCode;
  }

  /// User Change info
  Future<bool> changeUserInfo(String firstName, String lastName, String photo) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}private/user/editUserDetails');

    var response = await http.put(
      url,
      headers: {
        'Content-Type':'application/json',
        'Authorization': token
      },
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "patronymic": "",
        "photo": photo
      })
    );


    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// User Change password
  Future<bool> changeUserPassword(String oldPassword, String newPassword) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}private/user/changePassword?newPassword=$newPassword&oldPassword=$oldPassword');

    var response = await http.post(
        url,
        headers: {
          'Content-Type':'application/json',
          'Authorization': token
        },
    );


    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
