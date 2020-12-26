import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';

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
                    top: SizeConfig.defaultSize + 6,
                    bottom: SizeConfig.defaultSize),
                child: Text(
                  'Selected image',
                  style: TextStyle(
                    fontFamily: 'Futura PT',
                    fontSize: 22,
                    color: Colors.black,
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
                  : Container(height: SizeConfig.defaultSize * 15),
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
    String fileName = Path.basename(picture.path);
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    firebase_storage.UploadTask uploadTask = ref.putFile(picture);
    await uploadTask.whenComplete(() => null);
    String uploadedImageUrl = await ref.getDownloadURL();

    SharedPreferences savePrefs = await SharedPreferences.getInstance();
    savePrefs.setString('IMAGEURL', uploadedImageUrl);
  }
}
