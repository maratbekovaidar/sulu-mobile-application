
import 'package:flutter/material.dart';

class PasswordRegistrationStep extends StatefulWidget {
  const PasswordRegistrationStep({Key? key, required this.firstName, required this.lastName, required this.phoneNumber}) : super(key: key);

  final String firstName;
  final String lastName;
  final String phoneNumber;


  @override
  State<PasswordRegistrationStep> createState() => _PasswordRegistrationStepState();
}

class _PasswordRegistrationStepState extends State<PasswordRegistrationStep> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
