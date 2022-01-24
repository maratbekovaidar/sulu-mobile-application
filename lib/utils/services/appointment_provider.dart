

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sulu_mobile_application/utils/model/comment_model.dart';
import 'package:sulu_mobile_application/utils/model/establishment_models/appointment_model.dart';
import 'package:sulu_mobile_application/utils/services/upload_image_provider.dart';


class AppointmentProvider {


  /// Secure Storage
  FlutterSecureStorage storage = const FlutterSecureStorage();


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


  /// Set Comment
  Future<bool> setCommentService(int establishmentId, int masterDataId, double star, String comment, List<XFile> images) async {

    /// Image provider
    UploadImageProvider _imageProvider = UploadImageProvider();

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

          bool imageResult = await _imageProvider.uploadFeedbackImage(images, jsonDecode(response.body)['data']);

          if(imageResult) {
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


}