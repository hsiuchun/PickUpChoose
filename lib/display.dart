// import 'dart:html';

import 'dart:convert';

import 'result.dart';
import 'dart:io';
import 'dart:io' as io;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:rive/rive.dart' as rive;
import 'mangodb.dart' as mango;
import 'main.dart';

class DetailResultPage extends StatefulWidget {
  var receiveimg;
  var injureData;
  DetailResultPage({this.receiveimg, this.injureData});
  @override
  _DetailResultPageState createState() =>
      _DetailResultPageState(receiveimg: receiveimg, injureData: injureData);
}

class _DetailResultPageState extends State<DetailResultPage> {
  File? originimg;
  var receiveimg;
  var injureData;
  String level = '';

  _DetailResultPageState({this.receiveimg, this.injureData});

  void initState() {
    getDataTFromDB(context);
    super.initState();
  }

  Future getDataTFromDB(BuildContext context) async {
    final conn = new mango.DBConnection();
    String getimgtext = await conn.doDB(originimg);
    var getimg = Image.memory(
        base64Decode(getimgtext.substring(2, getimgtext.length - 1)));
    setState(() {
      originimg = null;
      receiveimg = getimg;
      // level = new_level;
    });
  }

  // Widget gradinglevels() {
  //   return new Row(
  //       children: List.generate(grading.length, (index) {
  //     return gradingLevel(context, index);
  //   }));
  // }

  // Widget getGradingLevels(List<String> strings) {
  //   List<Widget> list = new List.generate(grading.length, );
  //   for (var i = 0; i < strings.length; i++) {
  //     list.add(gradingLevel(context, i));
  //   }
  //   return new Row(children: list);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            //   FutureBuilder(future: uploadImageToFirebase(context), builder: (context, snapshot)
            // {if(snapshot.connectionState==ConnectionState.waiting) {return CircularProgressIndicator();}
            // else{
            ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            '測試標題一',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          subtitle: Text('測試內容一'),
          leading: Icon(
            Icons.event_seat,
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text(
            '測試標題二',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          subtitle: Text('測試內容二'),
          leading: Icon(
            Icons.event_seat,
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text(
            '測試標題三',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          subtitle: Text('測試內容三'),
          leading: Icon(
            Icons.event_seat,
            color: Colors.blue,
          ),
        ),
      ],
      // );}})
    ));
  }
}
