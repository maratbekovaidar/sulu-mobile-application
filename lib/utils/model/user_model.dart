import 'package:sulu_mobile_application/utils/model/city_model.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String patronymic;
  final String photo;
  final CityModel city;

  UserModel({
      required this.city,
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
      photo: json['photo'] ?? 'https://afitat-bol.com/wp-content/uploads/2021/03/default-user-avatar.jpg',
      city: CityModel.fromJson(json['cityDto']));
}
