//Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendor_app/Components/Custom_Scaffold.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Models/Movies_Model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return WillPopScope(
      child: CustomScaffold(
        scaffoldBody: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.defaultSize),
              height: SizeConfig.defaultSize * 70,
              child: MoviesStream(),
            ),
          ],
        ),
        isHome: true,
      ),
      onWillPop: _onWillPop,
    );
  }

  // ignore: missing_return
  Future<bool> _onWillPop() {
    SystemNavigator.pop();
  }
}
