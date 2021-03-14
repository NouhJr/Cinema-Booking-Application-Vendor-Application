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
        final movies = snapshot.data.docs.reversed;
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

        return ListView.builder(
          itemCount: moviesList.length,
          itemBuilder: (context, i) => Column(children: <Widget>[
            moviesList[i],
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
    return ListTile(
      leading: Image.network(
        movieImg,
      ),
      title: Text(
        movieTitle,
        style: TextStyle(
          fontFamily: 'Futura PT',
          fontSize: 22,
          color: MainFontsColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        movieDesc,
        style: TextStyle(
          fontFamily: 'Futura PT',
          fontSize: 18,
          color: SubFontsColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        CustomRouter().navigator(
            context,
            MovieDetails(
              documentID: docID,
            ));
      },
    );
  }
}
