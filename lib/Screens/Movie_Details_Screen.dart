import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Components/Constants.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({
    this.movieTitle,
    this.movieDescription,
    this.movieTime,
    this.movieImage,
    this.movieSeats,
    this.documentID,
  });
  final String movieTitle;
  final String movieDescription;
  final String movieTime;
  final String movieImage;
  final String documentID;
  final int movieSeats;
  @override
  _MovieDetailsState createState() => _MovieDetailsState(
        title: movieTitle,
        description: movieDescription,
        time: movieTime,
        image: movieImage,
        docID: documentID,
        seats: movieSeats,
      );
}

class _MovieDetailsState extends State<MovieDetails> {
  _MovieDetailsState({
    this.title,
    this.description,
    this.time,
    this.image,
    this.seats,
    this.docID,
  });
  final String title;
  final String description;
  final String time;
  final String image;
  final String docID;
  final int seats;

  final fireStore = FirebaseFirestore.instance;

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
                  'Time :',
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
                    fontSize: 20.0,
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
                    fontSize: 20.0,
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
    try {
      await fireStore.collection('Movies').doc(docID).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
