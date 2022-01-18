
class ScheduleModel {
  final int id;
  final String day;

  ScheduleModel({required this.id, required this.day});
  factory ScheduleModel.fromJson(json) => ScheduleModel(id: json['id'], day: json['day']);

}