import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/Home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    //Start point (Home Screen)
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
