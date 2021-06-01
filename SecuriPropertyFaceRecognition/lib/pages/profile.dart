import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'package:alert/alert.dart';

class Profile extends StatelessWidget {
  Profile({Key key, @required this.username}) : super(key: key);

  final String username;
  final databaseRef = FirebaseDatabase.instance.reference();
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final String lock = '1';
  final String unlock = '0';

  void addData(String data) {
    databaseRef.child(username).set({
      'Unlocker': data,
    });
  }

  void updateData(String data) {
    databaseRef.child(username).update({
      'Unlocker': data,
    });
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
          '   Welcome back, ' + username + '!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Here you can unlock the safe',
              style: TextStyle(
                  color: Color(0xfffd16900),
                  fontWeight: FontWeight.w900,
                  fontSize: 33.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                addData(unlock);
                Alert(message: 'The Safe has been Unlocked').show();
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
                  height: 100.0,
                  width: size.width * 0.5,
                  child: Center(
                    child: Text(
                      'Unlock',
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
              height: 40.0,
            ),
            GestureDetector(
              onTap: () {
                updateData(lock);
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
                Alert(message: 'The Safe has been Locked').show();
                HapticFeedback.heavyImpact();
              },
              child: Card(
                elevation: 10.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
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
                  height: 100.0,
                  width: size.width * 0.5,
                  child: Center(
                    child: Text(
                      'Lock',
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
      ),
    );
  }
}
