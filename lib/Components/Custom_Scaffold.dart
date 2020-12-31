//Import necessary packages
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Screens/Adding_New_Movie_Screen.dart';
import 'package:vendor_app/Screens/Notifications_Screen.dart';

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
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: SubMainColor,
              ),
              onPressed: () {
                CustomRouter().navigator(context, NotificationsScreen());
              },
              iconSize: 35,
            ),
          ],
          leading: Container(),
        ),
        backgroundColor: Colors.blueGrey[900],
        body: bodyFromHome,
        floatingActionButton: showFAB
            ? FloatingActionButton.extended(
                onPressed: () {
                  CustomRouter().navigator(context, AddingMovies());
                },
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
              )
            : null);
  }
}
