import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'profile.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  // DocumentReference sightingRef = Firestore.instance.collection(“profilepic”).doc();
  File imageFile;
  String url;

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    taskSnapshot.ref.getDownloadURL().then((value) {
      url = '$value';
      FirebaseFirestore.instance
          .collection("Users")
          .doc(auth.currentUser.email)
          .update({'url': '$value'});
    });
    print('Done' + url);
  }

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose an option',
              style: TextStyle(
                color: Color(0xfffd16900),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.purple,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text('Gallery'),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xfffd16900),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.purple,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text('Camera'),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xfffd16900),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // margin: EdgeInsets.symmetric(horizontal: 30.0),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          //height: 50.0,
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(Radius.circular(8.0)),
              gradient: LinearGradient(
                  // begin: Alignment.centerLeft,
                  // end: Alignment.centerRight,
                  colors: [Color(0xfff2e3cb8), Color(0xfff9830b8)]),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    color: Color(0xfff2e3cb8),
                    blurRadius: 5.0),
                BoxShadow(
                    offset: Offset(0, 0),
                    color: Color(0xfff652eb8),
                    blurRadius: 5.0),
                BoxShadow(
                    offset: Offset(0, 0),
                    color: Color(0xfff9830b8),
                    blurRadius: 5.0),
              ]),
        ),
        title: Text(
          "Pick Your Image",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Card(
                child: (imageFile == null)
                    ? Text('Choose Image')
                    : Image.file(File(imageFile.path)),
              ),
              GestureDetector(
                onTap: () {
                  _showChoiceDialog(context);
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                            colors: [Color(0xfff2e3cb8), Color(0xfff9830b8)]),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff2e3cb8),
                              blurRadius: 16.0),
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff652eb8),
                              blurRadius: 16.0),
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff9830b8),
                              blurRadius: 16.0),
                        ]),
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  uploadImageToFirebase(context);
                  Navigator.pop(context, true);
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        gradient: LinearGradient(
                            colors: [Color(0xfff2e3cb8), Color(0xfff9830b8)]),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff2e3cb8),
                              blurRadius: 16.0),
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff652eb8),
                              blurRadius: 16.0),
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Color(0xfff9830b8),
                              blurRadius: 16.0),
                        ]),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = File(pickedFile.path);
    });
    Navigator.pop(context);
  }
}
