import 'dart:async';

import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'profile.dart';

class NavBar extends StatefulWidget {
  final String username, password;
  final int index;

  NavBar(
    this.username,
    this.password,
    this.index,
  );

  @override
  _NavBarState createState() => _NavBarState(index);
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex;

  _NavBarState(this._selectedIndex);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(
        widget.username,
      ),
      Profile(widget.username, widget.password),
      LogOut(
        widget.username,
        widget.password,
      ),
    ];
    print(widget.username + widget.password);
    return Scaffold(
      backgroundColor: Color.fromRGBO(42, 44, 51, 100),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
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
                  blurRadius: 1.0),
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Color(0xfff652eb8),
                  blurRadius: 1.0),
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Color(0xfff9830b8),
                  blurRadius: 1.0),
            ]),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'LogOut',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xfffd16900),
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }
}

class LogOut extends StatefulWidget {
  final String username, password;
  LogOut(this.username, this.password);
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // alert on back button pressed
      title: Text(
        "Warning",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "You will be logged out of Session!",
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Cancel",
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NavBar(widget.username, widget.password, 0)));
            HapticFeedback.heavyImpact();
          },
        ),
        TextButton(
          child: Text(
            "OK",
          ),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            HapticFeedback.heavyImpact();
          },
        ),
      ],
    );
  }
}
