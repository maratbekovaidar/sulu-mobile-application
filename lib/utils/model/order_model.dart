
import 'package:sulu_mobile_application/utils/model/establishment_models/establishment_model.dart';

class OrderModel {

  final EstablishmentModel establishmentModel;
  String date;
  String time;
  String name;
  String phoneNumber;

  OrderModel({required this.establishmentModel, required this.date, required this.time, required this.name,
      required this.phoneNumber});
}