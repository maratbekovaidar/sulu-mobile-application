
import 'package:flutter/material.dart';

extension TimeToString on TimeOfDay {
  String showTime() {
    return (hour.toString().length == 1 ? "0" + hour.toString() : hour.toString()) + ":" + (minute.toString().length == 1 ? "0" + minute.toString() : minute.toString());
  }
}