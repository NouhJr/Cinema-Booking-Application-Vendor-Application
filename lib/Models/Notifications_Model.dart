import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Screens/Notifications_Details_Screen.dart';

final _firestore = FirebaseFirestore.instance;

class NotificationsStream extends StatefulWidget {
  @override
  _NotificationsStreamState createState() => _NotificationsStreamState();
}

class _NotificationsStreamState extends State<NotificationsStream> {
  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Customer Notifications')
          .orderBy(
            "Time Stamp",
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: SubMainColor,
            ),
          );
        }
        final notifications = snapshot.data.docs;
        List<SingleNotifications> notificationsList = [];
        for (var item in notifications) {
          final userName = item.data()['User Name'];
          final userImage = item.data()['User Image'];
          final movieDocID = item.data()['Movie DocID'];
          final movieSeats = item.data()['Number Of Booked Seats'];

          final notificationsTile = SingleNotifications(
            movieSeats: movieSeats,
            movieDocID: movieDocID,
            userName: userName,
            userImage: userImage,
          );

          notificationsList.add(notificationsTile);
        }
        return ListView.builder(
          itemCount: notificationsList.length,
          itemBuilder: (context, i) => Column(children: <Widget>[
            notificationsList[i],
            Divider(
              color: SubMainColor,
              indent: 80.0,
              endIndent: 30.0,
              thickness: 0.8,
            ),
          ]),
        );
      },
    );
  }
}

class SingleNotifications extends StatelessWidget {
  SingleNotifications({
    this.userName,
    this.userImage,
    this.movieSeats,
    this.movieDocID,
  });
  final String userName;
  final String userImage;
  final int movieSeats;
  final String movieDocID;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        userImage,
      ),
      title: Text(
        "$userName reserved $movieSeats seat(s)",
        style: TextStyle(
          fontFamily: 'Futura PT',
          fontSize: 22,
          color: MainFontsColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        CustomRouter().navigator(
            context,
            NotificationsDetails(
              movieDocId: movieDocID,
              userName: userName,
              userImage: userImage,
              bookedSeats: movieSeats,
            ));
      },
    );
  }
}
