class MasterTypeModel {
  final int id;
  final String type;
  final int serviceTypeId;

  MasterTypeModel(
      {required this.id, required this.type, required this.serviceTypeId});

  factory MasterTypeModel.fromJson(json) => MasterTypeModel(
      id: json['id'],
      type: json['type'] ?? "Мастер",
      serviceTypeId: json['serviceTypeId']);
}
