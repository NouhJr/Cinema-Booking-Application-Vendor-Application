//Import packages.
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';

class Textfield extends StatelessWidget {
  Textfield({
    @required this.label,
    @required this.controller,
    @required this.hint,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(
        bottom: SizeConfig.defaultSize / 2,
      ),
      width: SizeConfig.defaultSize * 40,
      child: TextField(
        style: TextStyle(
          fontSize: 17.0,
          color: MainFontsColor,
        ),
        decoration: InputDecoration(
          fillColor: SubMainColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: SubMainColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: SubMainColor,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: MainFontsColor,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: MainFontsColor,
          ),
        ),
        cursorColor: SubMainColor,
        controller: controller,
      ),
    );
  }
}
