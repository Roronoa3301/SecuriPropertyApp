import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DevContact extends StatefulWidget {
  String username;
  DevContact(this.username);
  @override
  _DevContactState createState() => _DevContactState();
}

class _DevContactState extends State<DevContact> {
  @override
  Widget build(BuildContext context) {
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
          "Developer Contact",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Hi, ' + widget.username + ',',
              style: TextStyle(
                  color: Color(0xfffd16900),
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'My Name is Rudra Rao',
              style: TextStyle(
                  color: Color(0xfffd16900),
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'I am the developer of SecuriProperty',
              style: TextStyle(
                  color: Color(0xfffd16900),
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'This is my Contact Information',
              style: TextStyle(
                  color: Color(0xfffd16900),
                  fontWeight: FontWeight.w900,
                  fontSize: 24.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  'Pnone Number:',
                  style: TextStyle(
                      color: Color(0xfffd16900),
                      fontWeight: FontWeight.w900,
                      fontSize: 24.0),
                ),
                GestureDetector(
                  onTap: () async {
                    const url = "tel:+919820297354";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                    HapticFeedback.heavyImpact();
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      alignment: Alignment.center,
                      width: 165.0,
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
                        "+91 9820297354",
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
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Email:',
                  style: TextStyle(
                      color: Color(0xfffd16900),
                      fontWeight: FontWeight.w900,
                      fontSize: 24.0),
                ),
                GestureDetector(
                  onTap: () async {
                    const uri =
                        'mailto:rudrarao22@gmail.com?subject=Issues%20With%20The%20Product&body=Replace%20this%20text%20with%20your%20query.';
                    if (await canLaunch(uri)) {
                      await launch(uri);
                    } else {
                      throw 'Could not launch $uri';
                    }
                    HapticFeedback.heavyImpact();
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      alignment: Alignment.center,
                      width: 210.0,
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
                        "rudrarao22@gmail.com",
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
          ],
        ),
      ),
    );
  }
}
