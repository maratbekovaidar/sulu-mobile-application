class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String patronymic;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.patronymic});

  factory UserModel.fromJson(json) => UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      patronymic: json['patronymic']);
}
