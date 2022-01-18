

class AppointmentModel {


  final int id;
  final String appointmentDate;
  final String appointmentStartTime;
  final String appointmentEndTime;
  final String establishmentAddress;
  final String establishmentName;
  final String masterFirstname;
  final String masterLastname;
  final String serviceType;
  final int serviceId;

  AppointmentModel({
    required this.serviceId,
    required this.id,
    required this.appointmentDate,
    required this.appointmentStartTime,
    required this.appointmentEndTime,
    required this.establishmentAddress,
    required this.establishmentName,
    required this.masterFirstname,
    required this.masterLastname,
    required this.serviceType
  });

  factory AppointmentModel.fromJson(json) {

    print(json['serviceId']);

    return AppointmentModel(
        id: json['id'],
        appointmentDate: json['appointmentDate'],
        appointmentStartTime: json['appointmentStartTime'],
        appointmentEndTime: json['appointmentEndTime'] ?? "",
        establishmentAddress: json['establishmentAddress'],
        establishmentName: json['establishmentName'],
        masterFirstname: json['masterFirstname'],
        masterLastname: json['masterLastname'],
        serviceType: json['serviceType'],
        serviceId: json['serviceId']);
  }
}