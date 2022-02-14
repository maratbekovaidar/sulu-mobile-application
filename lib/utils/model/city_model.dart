

class CityModel {
  final int id;
  final String name;

  CityModel({required this.id, required this.name});

  factory CityModel.fromJson(json) => CityModel(id: json['id'], name: json['name']);
}