class ServiceModel {
  final int id;
  final String name;
  final double cost;
  final String description;
  final int typeId;
  final int discount;
  final int establishmentId;
  final int subTypeId;

  ServiceModel(
      {required this.id,
      required this.name,
      required this.cost,
      required this.description,
      required this.typeId,
      required this.discount,
      required this.establishmentId,
      required this.subTypeId});

  factory ServiceModel.fromJson(json) => ServiceModel(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      description: json['description'],
      typeId: json['typeId'],
      discount: json['discount'],
      establishmentId: json['establishmentId'],
      subTypeId: json['subTypeId']);
}
