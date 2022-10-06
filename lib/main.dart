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
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Login(),
              )
            ]),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("prihlaseny uzivatel"),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int i) {
                      MapEntry<int, String> item = users[i];
                      return CheckboxListTile(
                        title: Text(item.value),
                        value: LOGGED_USER_ID == item.key,
                        onChanged: (bool? value) {
                          if (item.key != OPPONENT_ID)
                            setState(() {
                              LOGGED_USER_ID = item.key;
                              LOGGED_USER_LOGIN = item.value;
                            });
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text("Komu volat?"),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int i) {
                      MapEntry<int, String> item = users[i];
                      return CheckboxListTile(
                        title: Text(item.value),
                        value: OPPONENT_ID == item.key,
                        onChanged: (bool? value) {
                          if (item.key != LOGGED_USER_ID)
                            setState(() {
                              OPPONENT_ID = item.key;
                              OPPONENT_LOGIN = item.value;
                            });
                        },
                      );
                    }),
              )
            ],
          ),
        )
      ],
    );
  }
}
