import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickblox_sdk_example/credentials.dart';
import 'package:quickblox_sdk_example/screens/webrtc_screen.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quickblox SDK'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: [
            MaterialButton(
                minWidth: 200,
                child: Text('WebRTC'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebRTCScreen(),
                    ))),
            Login()
          ]),
        ));
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    _permission();
  }

  void _permission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  final String firstLogin = "test9";
  final String secondLogin = "test11";

  final int firstId = 135870266;
  final int secondId = 135870267;

  int _currentId = LOGGED_USER_ID;
  String _currentLogin = USER_LOGIN;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_currentId == firstId) {
          _currentId = secondId;
          _currentLogin = secondLogin;
          USER_LOGIN = secondLogin;
          LOGGED_USER_ID = secondId;
          OPPONENT_ID = firstId;
          OPPONENTS_IDS = [firstId];
        } else {
          _currentId = firstId;
          _currentLogin = firstLogin;
          USER_LOGIN = firstLogin;
          LOGGED_USER_ID = firstId;
          OPPONENT_ID = secondId;
          OPPONENTS_IDS = [secondId];
        }
        setState(() {});
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Text("USER LOGIN: ${_currentLogin} \n USER ID: ${_currentId}",
              style: TextStyle(fontSize: 14))),
    );
  }
}
