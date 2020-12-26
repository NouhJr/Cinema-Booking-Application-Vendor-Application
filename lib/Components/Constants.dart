//Import necessary packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///*************************COLORS**************************/
const MainColor = Color(0xFF4b0082);
const SubMainColor = Color(0xFFffc045);
const MainFontsColor = Color(0xFFffc045);
const SubFontsColor = Color(0xFFffffff);

///*************************App Bar Text Style**************************/
const AppBarFontStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: MainFontsColor,
);

const AppBarLabeledBottomFontStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
);

const AppBarUnLabeledBottomFontStyle = TextStyle(
  fontSize: 16.0,
);

///*************************Movies Label Text Style**************************/
const MoviesLabelFontStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.italic,
);

///*************************Movies Card Decoration**************************/
const MoviesCardDecoration = BoxDecoration(color: SubMainColor, boxShadow: [
  BoxShadow(
    blurRadius: 2.5,
    spreadRadius: 1.0,
    offset: Offset(
      0,
      2.0,
    ),
  )
]);
