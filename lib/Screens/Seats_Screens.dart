//Import necessary packages
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Custom_Scaffold.dart';

class Seats extends StatefulWidget {
  @override
  _SeatsState createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHome: false,
    );
  }
}
