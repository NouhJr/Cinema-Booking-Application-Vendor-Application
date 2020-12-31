import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Screens/Book_Seats_Screen.dart';

class NotificationsDetails extends StatefulWidget {
  NotificationsDetails({
    this.movieDocId,
    this.userName,
    this.userImage,
    this.bookedSeats,
  });
  final String movieDocId;
  final String userName;
  final String userImage;
  final int bookedSeats;
  @override
  _NotificationsDetailsState createState() => _NotificationsDetailsState();
}

class _NotificationsDetailsState extends State<NotificationsDetails> {
  String title = '';
  String time = '';
  int seats = 0;

  final fireStore = FirebaseFirestore.instance;
  void getData() async {
    final doc =
        await fireStore.collection('Movies').doc(widget.movieDocId).get();
    var movieTitle = doc['Title'];
    var movieTime = doc['Time'];
    var movieSeats = doc['Number of seats'];

    setState(() {
      title = movieTitle;
      time = movieTime;
      seats = movieSeats;
    });
  }

  @override
  void initState() {
    getData();
    Future.delayed(Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: [
          Row(
            children: [
              //Image container.
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize * 5.0,
                  left: SizeConfig.defaultSize * 2.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: SubMainColor,
                    width: 5,
                  ),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  child: new CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.userImage)),
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize * 5.0,
                  left: SizeConfig.defaultSize * 2.0,
                ),
                child: Text(
                  widget.userName,
                  style: TextStyle(
                    color: MainFontsColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 4.0,
              left: SizeConfig.defaultSize - 4.0,
            ),
            child: Text(
              "This user booked ${widget.bookedSeats} seats for movie '$title' at show time : $time .",
              style: TextStyle(
                color: MainFontsColor,
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.defaultSize * 6.0,
          ),
          Divider(
            color: SubMainColor,
            indent: 80.0,
            endIndent: 80.0,
            thickness: 1.0,
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 4.0,
              right: SizeConfig.defaultSize * 12.0,
            ),
            child: Text(
              "Remaining unreserved seats : $seats",
              style: TextStyle(
                color: MainFontsColor,
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "View Seats",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey[900],
          ),
        ),
        backgroundColor: SubMainColor,
        icon: Icon(
          Icons.grid_view,
          color: Colors.blueGrey[900],
          size: 30.0,
        ),
        onPressed: () {
          CustomRouter().navigator(
              context,
              BookSeat(
                movieDocID: widget.movieDocId,
              ));
        },
      ),
    );
  }
}
