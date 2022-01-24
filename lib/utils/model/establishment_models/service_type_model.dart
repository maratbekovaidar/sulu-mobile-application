
class ServiceTypeModel {
  final int id;
  final String name;

  ServiceTypeModel({required this.id, required this.name});
  factory ServiceTypeModel.fromJson(json) => ServiceTypeModel(id: json['id'], name: json['name']);

}