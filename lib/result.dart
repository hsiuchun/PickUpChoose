// import 'dart:html';

import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/material.dart';\
import 'package:image_picker/image_picker.dart';
// import 'package:imagebutton/imagebutton.dart';
import 'package:path/path.dart' as p;
import 'package:rive/rive.dart' as rive;
import 'mangodb.dart' as mango;
import 'dart:convert';
import 'main.dart';

class ResultPage extends StatefulWidget {
  var receiveimg;
  File? originimg;
  ResultPage({this.receiveimg, this.originimg});
  @override
  _ResultPageState createState() =>
      _ResultPageState(receiveimg: receiveimg, originimg: originimg);
}

class _ResultPageState extends State<ResultPage> {
  var receiveimg;
  File? originimg;
  final conn = new mango.DBConnection();
  String level = '';
  _ResultPageState({this.receiveimg, this.originimg});

  void initState() {
    // uploadImageToFirebase(context);
    uploadImageToMango(context);
    super.initState();
  }

  Future uploadImageToMango(BuildContext context) async {
    String getimgtext = await conn.doDB(originimg);
    var getimg = Image.memory(
        base64Decode(getimgtext.substring(2, getimgtext.length - 1)));
    setState(() {
      originimg = null;
      receiveimg = getimg;
      // level = new_level;
    });
  }

  void btnClickEvent() {
    print('btnClickEvent...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(250.0),
                    bottomRight: Radius.circular(250.0)),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(116, 148, 40, 0.8),
                  Color.fromRGBO(173, 219, 64, 1)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "PickUpChoose",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                // easterEgg(context),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: receiveimg != null
                              ? receiveimg
                              : rive.RiveAnimation.asset('assets/loading.riv'),
                          // onPressed: pickImage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget easterEgg(BuildContext context) {
//   return Container(
//     child: Stack(
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
//           margin: const EdgeInsets.only(
//               top: 20, left: 20.0, right: 20.0, bottom: 10.0),
//           child: ImageButton(
//             children: <Widget>[],
//             width: 30,
//             height: 30,
//             paddingTop: 30,
//             pressedImage: Image.asset("assets/logo_round.png"),
//             unpressedImage: Image.asset("assets/logo_round.png"),
//             onTap: () {
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('這裡什麼都沒有'),
//                     content: Container(
//                       child: Text('請返回上一頁'),
//                     ),
//                     actions: <Widget>[
//                       FlatButton(
//                         color: Color.fromRGBO(50, 168, 82, 1),
//                         child: Text('OK'),
//                         onPressed: () {
//                           // Navigator.of(context).pop();
//                           // Navigator.of(context).pop();
//                           Navigator.pushNamed(context, "main");
//                           // Navigator.popUntil(context, (route) {
//                           //   return route.settings.name == "/";
//                           // });
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }
