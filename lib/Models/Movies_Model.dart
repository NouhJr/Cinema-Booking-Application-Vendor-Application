import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Components/FlushBar.dart';
import 'package:vendor_app/Screens/Movie_Details_Screen.dart';
import 'package:vendor_app/Screens/Notifications_Screen.dart';

final _firestore = FirebaseFirestore.instance;

class MoviesStream extends StatefulWidget {
  @override
  _MoviesStreamState createState() => _MoviesStreamState();
}

class _MoviesStreamState extends State<MoviesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Movies').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: MainColor,
            ),
          );
        }
        final movies = snapshot.data.docs;
        List<SingleMovie> moviesList = [];
        for (var movie in movies) {
          final movieName = movie.data()['Title'];
          final movieDescription = movie.data()['Description'];
          final movieImage = movie.data()['Image'];
          final movieTime = movie.data()['Time'];
          final movieSeats = movie.data()['Number of seats'];
          final doc = movie.data()['DocID'];

          final movieCard = SingleMovie(
            movieTitle: movieName,
            movieImg: movieImage,
            movieDesc: movieDescription,
            movieSeats: movieSeats,
            movieTime: movieTime,
            docID: doc,
          );

          moviesList.add(movieCard);
        }

        final fbm = FirebaseMessaging();
        fbm.configure(
          onMessage: (msg) {
            Warning().errorMessage(
              context,
              title: "New seats reserved !",
              message:
                  "a user reserved new seats, view it now in notifications.",
              icons: Icons.notifications_active,
            );
            return;
          },
          onLaunch: (msg) {
            CustomRouter().navigator(context, NotificationsScreen());
            return;
          },
          onResume: (msg) {
            CustomRouter().navigator(context, NotificationsScreen());
            return;
          },
        );
        fbm.subscribeToTopic('VendorNotfication');

        return GridView.builder(
            itemCount: moviesList.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return moviesList[index];
            });
      },
    );
  }
}

class SingleMovie extends StatelessWidget {
  SingleMovie({
    this.movieTitle,
    this.movieImg,
    this.movieDesc,
    this.movieSeats,
    this.movieTime,
    this.docID,
  });
  final String movieTitle;
  final String movieImg;
  final String movieTime;
  final int movieSeats;
  final String movieDesc;
  final String docID;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: docID,
        child: Material(
          elevation: 10.0,
          child: InkWell(
            onTap: () {
              CustomRouter().navigator(
                  context,
                  MovieDetails(
                    documentID: docID,
                  ));
            },
            child: GridTile(
              footer: Container(
                decoration: MoviesCardDecoration,
                child: ListTile(
                  leading: Text(
                    movieTitle,
                    style: MoviesLabelFontStyle,
                    //textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              child: Image.network(
                movieImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
