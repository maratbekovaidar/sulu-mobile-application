
class MasterTypeModel {
  final int id;
  final String type;

  MasterTypeModel({required this.id, required this.type});

  factory MasterTypeModel.fromJson(json) => MasterTypeModel(id: json['id'], type: json['type'] ?? "Мастер");
}