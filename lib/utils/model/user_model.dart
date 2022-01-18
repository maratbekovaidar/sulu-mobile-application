class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String patronymic;
  final String photo;

  UserModel({
      required this.photo,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.patronymic});

  factory UserModel.fromJson(json) => UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      patronymic: json['patronymic'],
      photo: json['photo'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg');
}
