import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    // size.height = size.height * 0.8;
    path.quadraticBezierTo(
        size.width / 4, 260 /*180*/, size.width / 2, 275);
    path.quadraticBezierTo(
        3 / 4 * size.width, 290, size.width, 230);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}