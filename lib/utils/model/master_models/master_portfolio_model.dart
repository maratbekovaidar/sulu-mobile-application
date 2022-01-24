
import 'package:sulu_mobile_application/utils/model/master_models/master_type_model.dart';

class MasterPortfolioModel {

  final int id;
  final String masterPhoto;
  final String masterName;
  final int masterDataId;
  final List<MasterTypeModel> masterTypesDtoSet;
  final double rating;
  final List<String> images;

  MasterPortfolioModel({required this.id, required this.masterPhoto, required this.masterName,
      required this.masterDataId, required this.masterTypesDtoSet, required this.rating, required this.images});

  factory MasterPortfolioModel.fromJson(json) {

    List<dynamic> masterTypesDtoSetJson = json['masterTypesDtoSet'];

    List<String> images = [];
    json['photo1'] != null ? images.add(json['photo1']) : () {};
    json['photo2'] != null ? images.add(json['photo2']) : () {};
    json['photo3'] != null ? images.add(json['photo3']) : () {};
    json['photo4'] != null ? images.add(json['photo4']) : () {};

    return MasterPortfolioModel(
        id: json['id'],
        masterPhoto: json['masterPhoto'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
        masterName: json['masterName'],
        masterDataId: json['masterDataId'],
        masterTypesDtoSet: masterTypesDtoSetJson.map((e) => MasterTypeModel.fromJson(e)).toList(),
        rating: json['rating'],
        images: images
    );
  }

}