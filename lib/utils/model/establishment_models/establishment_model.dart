
import 'package:sulu_mobile_application/utils/model/schedule_model.dart';

class EstablishmentModel {
  final int id;
  final String name;
  final String description;
  final String city;
  final List<ScheduleModel> schedule;
  final String fromWorkSchedule;
  final String toWorkSchedule;
  final String phoneNumber;
  final String address;
  final int establishmentTypeId;
  List<String> images;
  final double rating;
  final int ownerId;

  EstablishmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.schedule,
    required this.fromWorkSchedule,
    required this.toWorkSchedule,
    required this.phoneNumber,
    required this.address,
    required this.images,
    required this.rating,
    required this.establishmentTypeId,
    required this.ownerId,
  });

  factory EstablishmentModel.fromJson(json) {

    List<String> images = [
      json['photo1'] ?? "assets/images/salon.jpg",
      json['photo2'] ?? 'assets/images/salon.jpg',
      json['photo3'] ?? 'assets/images/salon.jpg',
      json['photo4'] ?? 'assets/images/salon.jpg',
      json['photo5'] ?? 'assets/images/salon.jpg',
    ];

    List<dynamic> scheduleJson = json['schedule'];
    return EstablishmentModel(
        id: json['id'] ?? 1,
        name: json['name'],
        description: json['description'],
        city: json['city'] ?? "Nur-Sultan",
        schedule: scheduleJson.map((e) => ScheduleModel.fromJson(e)).toList(),
        fromWorkSchedule: json['fromWorkSchedule'],
        toWorkSchedule: json['toWorkSchedule'],
        phoneNumber: json['phoneNumber'],
        address: json['address'] ?? "",
        images: images,
        rating: json['rating'] ?? 0,
        ownerId: json['ownerId'],
        establishmentTypeId: json['establishmentTypeId']);
  }
}
