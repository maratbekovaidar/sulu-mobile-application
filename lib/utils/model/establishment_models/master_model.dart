import 'package:sulu_mobile_application/utils/model/establishment_models/master_type_model.dart';
import 'package:sulu_mobile_application/utils/model/schedule_model.dart';

class MasterModel {
  final int id;
  final double rating;
  final List<MasterTypeModel> masterType;
  final String? photo;
  final List<ScheduleModel> schedule;
  final String firstName;
  final String lastName;
  final List<String> masterStartTime;

  MasterModel({
      required this.masterStartTime,
      required this.id,
      required this.rating,
      required this.masterType,
      required this.photo,
      required this.schedule,
      required this.firstName,
      required this.lastName});

  factory MasterModel.fromJson(json) {

    List masterTypeJson = json['masterType'];
    List scheduleJson = json['schedule'];
    List masterTime =  json['masterStartTime'];

    return MasterModel(
        id: json['id'],
        rating: json['rating'],
        masterType: masterTypeJson.map((e) => MasterTypeModel.fromJson(e)).toList(),
        photo: "",
        schedule: scheduleJson.map((e) => ScheduleModel.fromJson(e)).toList(),
        firstName: json['firstname'] ?? "S",
        lastName: json['lastname'] ?? "Мастер", masterStartTime: masterTime.map((e) => e.toString()).toList()
    );
  }

}
