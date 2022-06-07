import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'main.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rive/rive.dart' as rive;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await firebase_core.Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PickUpChoose',
      theme: ThemeData(fontFamily: 'Righteous-Regular'),
      home: HomePage(),
      routes:{"main":(context) => UploadingImageToFirebaseStorage(),},
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  late rive.RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = rive.SimpleAnimation('defalut', autoplay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Stack(children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          margin: const EdgeInsets.only(
              top: 10, left: 20.0, right: 20.0, bottom: 500.0),
          child: Align(
            child: Text(
              "PickUpChoose",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 5,
                  color: Colors.blueGrey[900],
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        Container(
            // padding: const EdgeInsets.only(top: 20.0),
            child: Center(
          child: rive.RiveAnimation.asset('assets/jujube.riv'),
        )),
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                margin: const EdgeInsets.only(
                    top: 600, left: 120.0, right: 100.0, bottom: 20.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [orange, green],
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UploadingImageToFirebaseStorage()));
                  },
                  child: Text(
                    "START",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
