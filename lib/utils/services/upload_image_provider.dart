


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

  /// Upload comment or feedback image
  Future<bool> uploadFeedbackImage(List<XFile> images, int id) async {
    var uri = Uri.parse('https://sulu.azurewebsites.net/private/image/feedback/uploadImageForEstablishmentFeedback?feedbackId=1');
    String token = (await storage.read(key: 'token'))!;


    // var formData = FormData.fromMap(
    //     {
    //       "files": images.map((image) async => await MultipartFile.fromFile(image.path, filename: image.name)).toList()
    //     }
    // );

    var formData = FormData.fromMap(
        {
          "files": [
            images.isNotEmpty ? await MultipartFile.fromFile(images[0].path,filename: images[0].name): null,
            images.length > 1 ? await MultipartFile.fromFile(images[1].path,filename: images[1].name) : null,
            images.length > 2 ? await MultipartFile.fromFile(images[2].path,filename: images[2].name) : null
          ]
        }
    );
    var response = await Dio().post(
        'https://sulu.azurewebsites.net/private/image/feedback/uploadImageForEstablishmentFeedback?feedbackId=$id',
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