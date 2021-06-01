import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:property_secure_app/auth.dart';
import 'package:property_secure_app/developercontact.dart';
import 'package:property_secure_app/uploadimage.dart';
import 'loginpage.dart';
import 'livestreammain.dart';
import 'dart:io';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'livestreammain2.dart';

class HomePage extends StatefulWidget {
  final String username;
  HomePage(
    this.username,
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = new AuthService();
  @override
  void initState() {
    // TODO: implement initState
    retriveUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 42, 44, 51),
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
          "Home",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                shape: BoxShape.rectangle,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 50.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url == null
                          ? 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'
                          : url),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    ' Hello,',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35.0,
                        color: Color(0xfffd16900)),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(widget.username,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 35.0,
                          color: Color(0xfffd16900))),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return new LiveStreamMain(
                        title: 'Live',
                      );
                    }));
                    HapticFeedback.heavyImpact();
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          gradient: LinearGradient(
                              colors: [Color(0xfffe85e0e), Color(0xfffe8940e)]),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe85e0e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe3870e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe8940e),
                                blurRadius: 5.0),
                          ]),
                      height: 125.0,
                      width: size.width * 0.5,
                      child: Center(
                        child: Text(
                          'Remote Camera 1',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return new LiveStreamMain2(
                        title: 'Live',
                      );
                    }));
                    HapticFeedback.heavyImpact();
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          gradient: LinearGradient(
                              colors: [Color(0xfffe85e0e), Color(0xfffe8940e)]),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe85e0e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe3870e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe8940e),
                                blurRadius: 5.0),
                          ]),
                      height: 125.0,
                      width: size.width * 0.5,
                      child: Center(
                        child: Text(
                          'Remote Camera 2',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () async {
                    await LaunchApp.openApp(
                        androidPackageName: 'com.example.SecuriFaceNet');
                    HapticFeedback.heavyImpact();
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          gradient: LinearGradient(
                              colors: [Color(0xfffe85e0e), Color(0xfffe8940e)]),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe85e0e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe3870e),
                                blurRadius: 5.0),
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color(0xfffe8940e),
                                blurRadius: 5.0),
                          ]),
                      height: 125.0,
                      width: size.width * 0.5,
                      child: Center(
                        child: Text(
                          'Unlocker',
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(100, 42, 44, 51),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: Text(
                    'Welcome ' + widget.username,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  decoration: BoxDecoration(
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
              ),
              ListTile(
                title: Text('Developer Contact'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new DevContact(widget.username);
                  }));
                  HapticFeedback.heavyImpact();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String url;
  retriveUrl() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser.email)
        .get()
        .then((value) {
      setState(() {
        url = value.data()['url'];
      });
    });
  }
}
