import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sulu_mobile_application/configuration/configuration.dart';
import 'package:sulu_mobile_application/utils/model/city_model.dart';
import 'package:sulu_mobile_application/utils/model/user_model.dart';

class UserProvider {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Login query
  Future<bool> login(String username, String password) async {
      var url = Uri.parse('${Configuration.host}public/auth/login');

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
      print(response.body);

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
      var url = Uri.parse('${Configuration.host}private/client/getLoggedUserInfo');

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
  Future<int> register(String firstName, String lastName, String patronymic, String phoneNumber, String password, int cityId) async {
    var url = Uri.parse('${Configuration.host}public/auth/register');


    var response = await http.post(
        url,
        body: jsonEncode({
          "firstName": firstName,
          "id": 0,
          "lastName": lastName,
          "password": password,
          "patronymic": "",
          "phoneNumber": phoneNumber,
          "cityId": cityId,
          "photo": "",

        }),
        headers: {
          'Content-Type':'application/json'
        }
    );

    return jsonDecode(response.body)["httpStatus"];
  }

  /// Send otp to backend with phone number
  Future<int> sendOtp(String phoneNumber) async {
    print("Before sending code" + phoneNumber);
    String code = await getOtp(phoneNumber);
    print(code);
    print("After sending code:" + phoneNumber);


    var url = Uri.parse('${Configuration.host}public/auth/addUserToVerification?code=$code&phoneNumber=$phoneNumber');
    print("Code have sent to back:" + phoneNumber);

    var response = await http.post(
        url,
        headers: {
          'Content-Type':'application/json'
        }
    );

    return jsonDecode(response.body)["httpStatus"];
  }

  /// Check phone number
  Future<bool> checkPhoneNumber(String phoneNumber) async {
    var url = Uri.parse('https://sulutest.kz/public/auth/checkPhoneNumber?phoneNumber=$phoneNumber');
    var response = await http.post(
        url
    );

    if(jsonDecode(response.body)["httpStatus"] == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// confirm Otp
  Future<int> confirmOtp(String phoneNumber, String userCode) async {

    var url = Uri.parse('${Configuration.host}public/auth/verifyPhoneNumber?code=$userCode&phoneNumber=$phoneNumber');

    var response = await http.post(
        url,
        headers: {
          'Content-Type':'application/json'
        }
    );

    return jsonDecode(response.body)["httpStatus"];
  }

  /// Get OTP from smsc
  Future<String> getOtp(String phoneNumber) async {
    var url = Uri.parse('https://smsc.kz/sys/send.php?login=info@sulu.life&psw=c708adb7a37585ca85de3ba573feb71aa1e57cf2&phones=$phoneNumber&mes=code&call=1');
    var response = await http.post(
        url
    );
    String fulString= response.body.substring(response.body.indexOf("CODE"));
    String partString=fulString.substring(6);
    partString = partString.replaceFirst(" ", "");
    return partString;
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

  /// Get Cities
  Future<List<CityModel>> getCities() async {
    var url = Uri.parse('${Configuration.host}public/auth/getAllCities');

    var response = await http.get(
      url,
      headers: {
      'Content-Type':'application/json',
      },
    );

    if(response.statusCode == 200) {
      if(jsonDecode(response.body)["httpStatus"] == 200) {
        List<dynamic> jsonResult = jsonDecode(
            utf8.decode(response.bodyBytes))["data"];

        return jsonResult.map((json) => CityModel.fromJson(json)).toList();
      } else {
        throw Exception("Bad Request from http");
      }
    } else {
      throw Exception("Bad Request http status " + response.statusCode.toString());
    }

  }

  /// Change City
  Future<bool> changeCity(int cityId) async {
    String token;
    token = (await storage.read(key: 'token'))!;
    var url = Uri.parse('${Configuration.host}private/user/changeUserCityByUserToken?id=$cityId');

    var response = await http.put(
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
