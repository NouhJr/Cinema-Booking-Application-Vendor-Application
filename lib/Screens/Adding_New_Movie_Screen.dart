import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:vendor_app/Components/Constants.dart';
import 'package:vendor_app/Components/Custom_Text_Field.dart';
import 'package:vendor_app/Components/Size_Configurations.dart';
import 'package:vendor_app/Components/Navigator.dart';
import 'package:vendor_app/Components/FlushBar.dart';
import 'package:vendor_app/Screens/Image_Selection.dart';
import 'package:vendor_app/Screens/Home_Screen.dart';

class AddingMovies extends StatefulWidget {
  @override
  _AddingMoviesState createState() => _AddingMoviesState();
}

class _AddingMoviesState extends State<AddingMovies> {
  //variable '_image' to hold selected image.
  File _image;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //Size Configurations to resize widgets according to screen size.
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.defaultSize * 5.5,
        ),
        child: Column(
          children: [
            Textfield(
              controller: movieTilteController,
              label: 'Title',
              hint: 'Enter movie title...',
            ),
            Textfield(
              controller: movieDescriptionController,
              label: 'Description',
              hint: 'Enter movie description...',
            ),
            Textfield(
              controller: movieTimeController,
              label: 'Time',
              hint: 'Enter movie time...',
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.defaultSize * 2,
                left: SizeConfig.defaultSize,
              ),
              height: SizeConfig.defaultSize * 4,
              child: Row(
                children: [
                  Text(
                    'Image :',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: MainFontsColor,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                  ButtonTheme(
                    minWidth: SizeConfig.defaultSize * 12,
                    height: SizeConfig.defaultSize * 3,
                    child: RaisedButton(
                      color: SubMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Choose file',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: chooseFile,
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.defaultSize,
                  ),
                  ButtonTheme(
                    minWidth: SizeConfig.defaultSize * 12,
                    height: SizeConfig.defaultSize * 3,
                    child: RaisedButton(
                      color: SubMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Take picture',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: takePicture,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submit,
        label: Text(
          "Submit",
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
    );
  }

  ///*****************************BACK END****************************************/
  //Text Editing Controllers to get data from Text Fields.
  final movieTilteController = TextEditingController();
  final movieDescriptionController = TextEditingController();
  final movieTimeController = TextEditingController();

  void titleDispose() {
    movieTilteController.dispose();
    super.dispose();
  }

  void descriptionDispose() {
    movieDescriptionController.dispose();
    super.dispose();
  }

  void timeDispose() {
    movieTimeController.dispose();
    super.dispose();
  }

  //Method 'chooseFile' to make the user choose photo from device's gallary.
  Future chooseFile() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
    CustomRouter().navigator(
      context,
      Selection(
        picture: _image,
      ),
    );
  }

  //Method 'chooseFile' to make the user choose photo from device's gallary.
  Future takePicture() async {
    final _picker = ImagePicker();
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
    CustomRouter().navigator(
      context,
      Selection(
        picture: _image,
      ),
    );
  }

  Future submit() async {
    //Check if there is internet connection or not and display message error if not.
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Warning().errorMessage(
        context,
        title: "No internet connection !",
        message: "Pleas turn on wifi or mobile data",
        icons: Icons.signal_wifi_off,
      );

      //Ensure that 'Movie Title' field isn't empty.
    } else if (movieTilteController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie Title can't be empty !",
        message: 'Please enter movie title.',
        icons: Icons.warning,
      );
      //Ensure that 'Movie Description' field isn't empty.
    } else if (movieDescriptionController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie Description can't be empty !",
        message: 'Please enter movie description.',
        icons: Icons.warning,
      );
      //Ensure that 'Movie Time' field isn't empty.
    } else if (movieTimeController.text.isEmpty) {
      Warning().errorMessage(
        context,
        title: "Movie Time can't be empty !",
        message: 'Please enter movie time.',
        icons: Icons.warning,
      );
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var uploadedImageUrl = prefs.getString('IMAGEURL');
        await fireStore
            .collection('Movies')
            .doc(movieTilteController.text
                .replaceAll(new RegExp(r"\s+\b|\b\s"), ""))
            .set({
          'Title': movieTilteController.text,
          'Description': movieDescriptionController.text,
          'Image': uploadedImageUrl == null
              ? "https://firebasestorage.googleapis.com/v0/b/cinema-management-system-39a82.appspot.com/o/images.png?alt=media&token=23d14fd0-c816-49e8-8776-59cc4bca30f1"
              : uploadedImageUrl,
          'Number of seats': 47,
          'Time': movieTimeController.text,
          'DocID': movieTilteController.text
              .replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
          "Seats": [
            {"ID": 1, "Is Reserved": false, "User": ""},
            {"ID": 2, "Is Reserved": false, "User": ""},
            {"ID": 3, "Is Reserved": false, "User": ""},
            {"ID": 4, "Is Reserved": false, "User": ""},
            {"ID": 5, "Is Reserved": false, "User": ""},
            {"ID": 6, "Is Reserved": false, "User": ""},
            {"ID": 7, "Is Reserved": false, "User": ""},
            {"ID": 8, "Is Reserved": false, "User": ""},
            {"ID": 9, "Is Reserved": false, "User": ""},
            {"ID": 10, "Is Reserved": false, "User": ""},
            {"ID": 11, "Is Reserved": false, "User": ""},
            {"ID": 12, "Is Reserved": false, "User": ""},
            {"ID": 13, "Is Reserved": false, "User": ""},
            {"ID": 14, "Is Reserved": false, "User": ""},
            {"ID": 15, "Is Reserved": false, "User": ""},
            {"ID": 16, "Is Reserved": false, "User": ""},
            {"ID": 17, "Is Reserved": false, "User": ""},
            {"ID": 18, "Is Reserved": false, "User": ""},
            {"ID": 19, "Is Reserved": false, "User": ""},
            {"ID": 20, "Is Reserved": false, "User": ""},
            {"ID": 21, "Is Reserved": false, "User": ""},
            {"ID": 22, "Is Reserved": false, "User": ""},
            {"ID": 23, "Is Reserved": false, "User": ""},
            {"ID": 24, "Is Reserved": false, "User": ""},
            {"ID": 25, "Is Reserved": false, "User": ""},
            {"ID": 26, "Is Reserved": false, "User": ""},
            {"ID": 27, "Is Reserved": false, "User": ""},
            {"ID": 28, "Is Reserved": false, "User": ""},
            {"ID": 29, "Is Reserved": false, "User": ""},
            {"ID": 30, "Is Reserved": false, "User": ""},
            {"ID": 31, "Is Reserved": false, "User": ""},
            {"ID": 32, "Is Reserved": false, "User": ""},
            {"ID": 33, "Is Reserved": false, "User": ""},
            {"ID": 34, "Is Reserved": false, "User": ""},
            {"ID": 35, "Is Reserved": false, "User": ""},
            {"ID": 36, "Is Reserved": false, "User": ""},
            {"ID": 37, "Is Reserved": false, "User": ""},
            {"ID": 38, "Is Reserved": false, "User": ""},
            {"ID": 39, "Is Reserved": false, "User": ""},
            {"ID": 40, "Is Reserved": false, "User": ""},
            {"ID": 41, "Is Reserved": false, "User": ""},
            {"ID": 42, "Is Reserved": false, "User": ""},
            {"ID": 43, "Is Reserved": false, "User": ""},
            {"ID": 44, "Is Reserved": false, "User": ""},
            {"ID": 45, "Is Reserved": false, "User": ""},
            {"ID": 46, "Is Reserved": false, "User": ""},
            {"ID": 47, "Is Reserved": false, "User": ""}
          ],
          "Selected IDs": [],
          "Selected IDs Index": -1
        });

        await fireStore.collection('Vendor Notifications').doc().set({
          'Movie DOC ID': movieTilteController.text
              .replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
          'Time Stamp': DateTime.now(),
        });
        prefs.setString('IMAGEURL', null);
        CustomRouter().navigator(context, HomeScreen());
        Warning().errorMessage(
          context,
          title: "Created...!",
          message: "Movie created successfully.",
          icons: Icons.check_circle,
        );
      } catch (e) {
        Warning().errorMessage(
          context,
          title: "Failed creating new movie !",
          message: 'Try again later.',
          icons: Icons.warning,
        );
      }
    }
  }
}
