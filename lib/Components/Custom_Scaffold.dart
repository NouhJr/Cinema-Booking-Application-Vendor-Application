//Import necessary packages
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';

class CustomScaffold extends StatefulWidget {
  final Widget scaffoldBody;
  final bool isHome;
  CustomScaffold({
    this.scaffoldBody,
    this.isHome,
  });

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState(
        bodyFromHome: scaffoldBody,
        home: isHome,
      );
}

class _CustomScaffoldState extends State<CustomScaffold>
    with SingleTickerProviderStateMixin {
  final Widget bodyFromHome;
  final bool home;
  _CustomScaffoldState({
    this.bodyFromHome,
    this.home,
  });

  bool showFAB = true;
  bool isExtended = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      showFAB = home;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Management Panel",
            style: AppBarFontStyle,
          ),
          centerTitle: true,
          backgroundColor: MainColor,
          elevation: 1.0,
        ),
        backgroundColor: Colors.blueGrey[900],
        body: bodyFromHome,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            "Add new Movie",
            style: AppBarLabeledBottomFontStyle,
          ),
          backgroundColor: MainColor,
          icon: Icon(
            Icons.add,
            color: SubMainColor,
            size: 30.0,
          ),
        ));
  }
}
