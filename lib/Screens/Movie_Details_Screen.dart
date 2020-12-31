import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/FlushBar.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Screens/Home_Screen.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({
    this.documentID,
  });
  final String documentID;
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String title = '';
  String description = '';
  String time = '';
  String image =
      "https://firebasestorage.googleapis.com/v0/b/cinema-management-system-39a82.appspot.com/o/images.png?alt=media&token=23d14fd0-c816-49e8-8776-59cc4bca30f1";
  int seats = 0;

  final fireStore = FirebaseFirestore.instance;
  void getData() async {
    final doc =
        await fireStore.collection('Movies').doc(widget.documentID).get();
    var movieTitle = doc['Title'];
    var movieDescription = doc['Description'];
    var movieTime = doc['Time'];
    var movieImage = doc['Image'];
    var movieSeats = doc['Number of seats'];

    setState(() {
      title = movieTitle;
      description = movieDescription;
      time = movieTime;
      image = movieImage;
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
      backgroundColor: SubMainColor,
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.only(
                top: SizeConfig.defaultSize * 5,
                left: SizeConfig.defaultSize * 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            elevation: 10.0,
            child: Container(
              width: SizeConfig.defaultSize * 25.0,
              height: SizeConfig.defaultSize * 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.blueGrey[900],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // This will hold the Image in the back ground:
                  Container(
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: SizeConfig.defaultSize * 20.0,
                      height: SizeConfig.defaultSize * 30.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize,
              left: SizeConfig.defaultSize * 8.0,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 27.0,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: SizeConfig.defaultSize * 23.0,
            ),
            child: Text(
              'Story :',
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            height: SizeConfig.defaultSize * 13.0, //130.0,
            child: Text(
              description,
              style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 3.0,
            ),
            child: Row(
              children: [
                Text(
                  'Show Time :',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.defaultSize,
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.defaultSize * 30.0, //300.0,
            margin: EdgeInsets.only(
              top: SizeConfig.defaultSize * 3.0,
            ),
            child: Row(
              children: [
                Text(
                  'Seats :',
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.defaultSize,
                ),
                Text(
                  seats.toString(),
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: delete,
        backgroundColor: Colors.blueGrey[900],
        child: Icon(
          Icons.delete_forever_rounded,
          color: SubMainColor,
          size: 30.0,
        ),
      ),
    );
  }

  Future delete() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Pleas turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else {
      showDialog(
          context: context,
          child: AlertDialog(
            backgroundColor: Colors.blueGrey[900],
            elevation: 1.0,
            content: Text(
              'Do you want to delete this movie?',
              style: TextStyle(
                color: MainFontsColor,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            actions: [
              ButtonTheme(
                child: RaisedButton(
                  color: SubMainColor,
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    try {
                      await fireStore
                          .collection('Movies')
                          .doc(widget.documentID)
                          .delete();
                      CustomRouter().navigator(context, HomeScreen());
                      Warning().errorMessage(
                        context,
                        title: "Deleted...!",
                        message: "Movie deleted successfully.",
                        icons: Icons.check_circle,
                      );
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                ),
              ),
              ButtonTheme(
                child: RaisedButton(
                  color: SubMainColor,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ));
    }
  }
}
