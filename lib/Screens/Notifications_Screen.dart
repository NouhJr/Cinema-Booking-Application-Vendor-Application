import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Models/Notifications_Model.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.defaultSize,
        ),
        child: NotificationsStream(),
      ),
    );
  }
}
