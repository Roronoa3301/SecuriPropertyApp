import 'package:alert/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:property_secure_app/auth.dart';
import 'package:property_secure_app/registration.dart';
import 'homepage.dart';
import 'bottomnavbar.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isShown = true;
  String username;
  bool isLoading = false;
  AuthService _authService = new AuthService();
  sign_in() async {
    await _authService
        .signInEmailAndPass(email.text, password.text)
        .then((value) {
      if (value == email.text) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(email.text)
            .get()
            .then((doc) {
          print(doc['username']);
          setState(() {
            username = doc['username'];
            isLoading = true;
          });
          print(username);
        });
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NavBar(
                username,
                password.text,
                0,
              ),
            ),
          );
        });
      } else {
        Alert(message: value, shortDuration: false).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(42, 44, 51, 100),
      appBar: AppBar(
        flexibleSpace: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
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
          "Welcome to SecuirProperty",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.0),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/bl_neon_icon.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 65.0, bottom: 15.0),
              child: TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                style: TextStyle(color: Colors.purple),
                decoration: InputDecoration(
                  hoverColor: Color(0xfff27a127),
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffd16900))),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xfffd16900)),
                  hintText: 'Enter a valid email address such as abc@gmail.com',
                  hintStyle: TextStyle(color: Color(0xfffd16900)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextFormField(
                controller: password,
                keyboardType: TextInputType.emailAddress,
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
                    icon:
                        Icon(isShown ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfffd16900))),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xfffd16900)),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Color(0xfffd16900)),
                ),
              ),
            ),
            SizedBox(
              height: 120.0,
            ),
            GestureDetector(
              onTap: () {
                sign_in();
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
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new Registration();
                  }));
                  HapticFeedback.heavyImpact();
                },
                child: Text(
                  'New User? Create an Account',
                  style: TextStyle(color: Colors.purple, fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
