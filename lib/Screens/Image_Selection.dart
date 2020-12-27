import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:connectivity/connectivity.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Components/FlushBar.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Screens/Adding_New_Movie_Screen.dart';

class Selection extends StatefulWidget {
  Selection({this.picture});
  final File picture;

  @override
  _SelectionState createState() => _SelectionState(picture: picture);
}

class _SelectionState extends State<Selection> {
  _SelectionState({this.picture});
  final File picture;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Center(
          child: Column(
            children: [
              //Container to hold 'Selected image' label.
              Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize * 5.0,
                    bottom: SizeConfig.defaultSize),
                child: Text(
                  'Selected image',
                  style: TextStyle(
                    fontFamily: 'Futura PT',
                    fontSize: 22,
                    color: MainFontsColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              picture != null
                  ? Image.file(
                      picture,
                      height: SizeConfig.defaultSize * 15,
                    )
                  //Empty container to display if no image was selected.
                  : Image.asset(
                      "Assets/344-3449415_motorhead-logo-png-cinema-icon-png.png",
                      height: SizeConfig.defaultSize * 15,
                    )
              //Container(height: SizeConfig.defaultSize * 15),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: upload,
          label: Text(
            "Submit Image",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey[900],
            ),
          ),
          backgroundColor: SubMainColor,
          icon: Icon(
            Icons.check,
            color: Colors.blueGrey[900],
            size: 30.0,
          ),
        ),
      ),
    );
  }

  ///*********************************BACK END***********************************/

  //Method upload() to upload movie image to firebase storage.
  Future upload() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Pleas turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );
    } else {
      String fileName = Path.basename(picture.path);
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(picture);
      await uploadTask.whenComplete(() => null);
      String uploadedImageUrl = await ref.getDownloadURL();

      CustomRouter().navigator(context, AddingMovies());
      Warning().errorMessage(
        context,
        title: "Uploaded...!",
        message: "Image uploaded successfully.",
        icons: Icons.check_circle,
      );
      SharedPreferences savePrefs = await SharedPreferences.getInstance();
      savePrefs.setString('IMAGEURL', uploadedImageUrl);
    }
  }
}
