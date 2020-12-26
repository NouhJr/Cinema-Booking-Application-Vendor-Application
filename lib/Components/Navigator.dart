import 'package:flutter/material.dart';

class CustomRouter {
  void navigator(BuildContext context, var destination) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destination));
  }
}
