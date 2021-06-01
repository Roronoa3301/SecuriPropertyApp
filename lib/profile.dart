import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'uploadimage.dart';
import 'auth.dart';
import 'bottomnavbar.dart';

class Profile extends StatefulWidget {
  String username, password;
  Profile(
    this.username,
    this.password,
  );
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var usernamecontrol = TextEditingController();
  var passwordcontrol = TextEditingController();

  bool isShown = true;
  bool status = true;
  AuthService _authService = new AuthService();
  updateUser() async {
    await _authService
        .updateData(passwordcontrol.text, usernamecontrol.text)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(
            usernamecontrol.text,
            passwordcontrol.text,
            1,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    retriveUrl();
    // retriveUsername();
    // retrivePassword();
    super.initState();
    usernamecontrol = TextEditingController(text: widget.username);
    passwordcontrol = TextEditingController(text: widget.password);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Center(
        child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(url == null
                  ? 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'
                  : url),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(42, 44, 51, 100),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(
              height: 80.0,
            ),
            TextFormField(
              enabled: !status,
              controller: usernamecontrol,
              keyboardType: TextInputType.text,
              autofocus: false,
              style: TextStyle(color: Colors.purple),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffd16900)),
                ),
                labelText: 'Username',
                labelStyle: TextStyle(color: Color(0xfffd16900)),
                // hintText: 'Enter a valid Username',
                hintStyle: TextStyle(color: Color(0xfffd16900)),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              enabled: !status,
              controller: passwordcontrol,
              autofocus: false,
              obscureText: isShown,
              style: TextStyle(color: Colors.purple),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isShown = !isShown;
                    });
                  },
                  icon: Icon(isShown ? Icons.visibility : Icons.visibility_off),
                ),
                // hintText: 'Enter a valid Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffd16900)),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0xfffd16900)),
                hintStyle: TextStyle(color: Color(0xfffd16900)),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            status ? _getEditIcon() : Container(),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return new CameraWidget();
                    },
                  ),
                );
                HapticFeedback.heavyImpact();
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Color(0xfffd16900),
                  ),
                  child: Text(
                    'Upload Image',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: () {
                updateUser();
                retriveUrl();
                setState(() {
                  status = true;
                });
                HapticFeedback.heavyImpact();
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
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 30.0,
            decoration: BoxDecoration(
                color: Color(0xfffd16900),
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          status = false;
        });
        HapticFeedback.heavyImpact();
      },
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
