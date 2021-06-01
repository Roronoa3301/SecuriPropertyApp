import 'package:flutter/material.dart';
import 'package:remote_ip_camera/remote_ip_camera.dart';
import 'package:remote_ui/remote_ui.dart';
import 'package:quiver/async.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

class LiveStreamMain2 extends StatefulWidget {
  LiveStreamMain2({this.title});
  final String title;
  @override
  _LiveStreamMain2State createState() => _LiveStreamMain2State();
}

class _LiveStreamMain2State extends State<LiveStreamMain2> {
  bool recording = false;
  int _time = 0;
  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    // requestPermissions();
    startTimer();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: 1000),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() => _time++);
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Screenshot(
              controller: screenshotController,
              child: Expanded(
                child: RemoteManagerWidget(
                  parsers: [RemoteIpCameraFactory()],
                  onChanges: (key, value, {associatedData}) =>
                      debugPrint('$key change to $value'),
                  child: RemoteWidget(
                    definition: {
                      'type': 'column',
                      'children': [
                        {
                          'type': 'camera',
                          'stream': 'http://192.168.0.108',
                        }
                      ],
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _imageFile = null;
                    screenshotController
                        .capture(delay: Duration(milliseconds: 10))
                        .then((Uint8List image) async {
                      _imageFile = image;
                      final result = await ImageGallerySaver.saveImage(
                          _imageFile,
                          quality: 60,
                          name: 'screenshot1');
                      print(result);
                      showDialog(
                        context: context,
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('Screenshot Captured!'),
                          ),
                          body: Center(
                            child: Column(
                              children: [
                                _imageFile != null
                                    ? Image.memory(_imageFile)
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xfffd16900),
                      textStyle: TextStyle(color: Colors.white)),
                  child: Text(
                    'Capture',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
