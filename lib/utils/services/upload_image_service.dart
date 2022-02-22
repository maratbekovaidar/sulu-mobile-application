


import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sulu_mobile_application/configuration/configuration.dart';


class UploadImageService {

  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Upload user avatar image
  Future<bool> uploadUserImage(int id, String photo, String fileName) async {
    String token = (await storage.read(key: 'token'))!;

    var formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(photo,filename: fileName)
      }
    );


    var response = await Dio().post(
        '${Configuration.imageUploadUrl}private/image/user/uploadImage?userId=$id',
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
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
    String token = (await storage.read(key: 'token'))!;


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
        '${Configuration.imageUploadUrl}private/image/feedback/uploadImageForEstablishmentFeedback?feedbackId=$id',
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