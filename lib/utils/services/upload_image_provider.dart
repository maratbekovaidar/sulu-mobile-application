
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class UploadImageProvider {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Upload user avatar image
  Future<bool> uploadUserImage(int id, String photo, String fileName) async {
    var uri = Uri.parse('https://sulu.azurewebsites.net/public/auth/login');
    String token = (await storage.read(key: 'token'))!;
    var formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(photo,filename: fileName)
      }
    );
    var response = await Dio().post(
        'https://sulu.azurewebsites.net/private/image/user/uploadImage?userId=$id',
        data: formData,
        options: Options(
            headers: {
              'Content-Type':'application/json',
              'Authorization': token
            }
        )
    );
    if (response.statusCode == 200) {
     return true;
    } else {
      return false;
    }

  }

}