import 'package:FaceNetAuthentication/pages/db/database.dart';
import 'package:FaceNetAuthentication/pages/sign-in.dart';
import 'package:FaceNetAuthentication/pages/sign-up.dart';
import 'package:FaceNetAuthentication/services/facenet.service.dart';
import 'package:FaceNetAuthentication/services/ml_vision_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Services injection
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
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
          '        Face Recognition',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22.0,
          ),
        ),
        leading: Container(),
      ),
      body: !loading
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/bl_neon_icon.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignIn(
                              cameraDescription: cameraDescription,
                            ),
                          ),
                        );
                        HapticFeedback.heavyImpact();
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              gradient: LinearGradient(colors: [
                                Color(0xfffe85e0e),
                                Color(0xfffe8940e)
                              ]),
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
                          height: 85.0,
                          width: size.width * 0.5,
                          child: Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignUp(
                              cameraDescription: cameraDescription,
                            ),
                          ),
                        );
                        HapticFeedback.heavyImpact();
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              gradient: LinearGradient(colors: [
                                Color(0xfffe85e0e),
                                Color(0xfffe8940e)
                              ]),
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
                          height: 85.0,
                          width: size.width * 0.5,
                          child: Center(
                            child: Text(
                              'Register Face',
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
                        _dataBaseService.cleanDB();
                        HapticFeedback.heavyImpact();
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              gradient: LinearGradient(colors: [
                                Color(0xfffe85e0e),
                                Color(0xfffe8940e)
                              ]),
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
                          height: 85.0,
                          width: size.width * 0.5,
                          child: Center(
                            child: Text(
                              'Clear the Saved Faces',
                              style: TextStyle(
                                fontSize: 35.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await LaunchApp.openApp(
                            androidPackageName:
                                'com.example.property_secure_app');
                        HapticFeedback.heavyImpact();
                      },
                      child: Card(
                        elevation: 10.0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              gradient: LinearGradient(colors: [
                                Color(0xfffe85e0e),
                                Color(0xfffe8940e)
                              ]),
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
                          height: 85.0,
                          width: size.width * 0.5,
                          child: Center(
                            child: Text(
                              'Back to the Home Page',
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
