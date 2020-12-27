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
          'Image': uploadedImageUrl,
          'Number of seats': 47,
          'Time': movieTimeController.text,
          'DocID': movieTilteController.text
              .replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
        });
        Warning().errorMessage(
          context,
          title: "Created...!",
          message: "Movie created successfully.",
          icons: Icons.check_circle,
        );
        CustomRouter().navigator(context, HomeScreen());
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
