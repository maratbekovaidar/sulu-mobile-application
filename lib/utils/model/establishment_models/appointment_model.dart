

import 'package:sulu_mobile_application/utils/model/master_models/master_type_model.dart';

class AppointmentModel {

  final int id;
  final String appointmentDate;
  final String appointmentStartTime;
  final String establishmentAddress;
  final String establishmentName;
  final int establishmentId;
  final String masterName;
  final int masterDataId;
  final List<MasterTypeModel> masterType;
  final String serviceType;
  final int serviceId;

  AppointmentModel({
    required this.serviceId,
    required this.id,
    required this.appointmentDate,
    required this.appointmentStartTime,
    required this.establishmentAddress,
    required this.establishmentId,
    required this.establishmentName,
    required this.masterName,
    required this.masterDataId,
    required this.masterType,
    required this.serviceType
  });

  factory AppointmentModel.fromJson(json) {

    List<dynamic> masterTypeJson = json['masterType'];

    return AppointmentModel(
        id: json['id'],
        appointmentDate: json['appointmentDate'],
        appointmentStartTime: json['appointmentStartTime'],
        establishmentAddress: json['establishmentAddress'],
        establishmentName: json['establishmentName'],
        establishmentId: json['establishmentId'],
        masterName: json['masterName'],
        serviceType: json['serviceType'],
        serviceId: json['serviceId'],
        masterType: masterTypeJson.map((e) => MasterTypeModel.fromJson(e)).toList(),
        masterDataId: json['masterDataId']);
  }
}