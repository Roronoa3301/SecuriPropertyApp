import 'package:flutter/material.dart';
import 'auth.dart';
import 'loginpage.dart';
import 'uploadimage.dart';

class Registration extends StatefulWidget {
  static String tag = 'Registration-Page';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  AuthService _authService = new AuthService();
  regUser() async {
    await _authService
        .signUpWithEmailAndPasswordStudent(
            email.text, password.text, username.text)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: const EdgeInsets.only(top: 5.0),
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
              controller: username,
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
                hintText: 'Enter a valid Username',
                hintStyle: TextStyle(color: Color(0xfffd16900)),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              style: TextStyle(color: Colors.purple),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfffd16900)),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xfffd16900)),
                hintText: 'Enter a valid Email Address',
                hintStyle: TextStyle(color: Color(0xfffd16900)),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              controller: password,
              autofocus: false,
              obscureText: true,
              style: TextStyle(color: Colors.purple),
              decoration: InputDecoration(
                hintText: 'Enter a valid Password',
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
            // SizedBox(
            //   height: 10.0,
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       primary: Color(0xfffd16900), onPrimary: Colors.purple),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return new CameraWidget();
            //         },
            //       ),
            //     );
            //   },
            //   child: Text(
            //     'Upload Image',
            //     style:
            //         TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () {
                regUser();
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
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            FlatButton(
              child: Text('Already have an Account? Click here.',
                  style: TextStyle(color: Colors.purple, fontSize: 15)),
              onPressed: () {
                Navigator.of(context).popUntil(
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
