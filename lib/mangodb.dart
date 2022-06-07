import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'result.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:rive/rive.dart' as rive;
import 'mangodb.dart' as mango;

import 'main.dart';
import 'result.dart';

class DBConnection {
  final String userName = "android";
  final String password = "624001479";
  final String _host = "140.127.220.113";
  final String _port = "27017";
  final String _dbName = "image-db";

  var collection = "images";

  var db;
  var userCollection;

  Future<String> doDB(var originimg) async {
    var imageFile = originimg;
    var URL = "mongodb://$userName:$password@$_host:$_port/$_dbName";
    print(URL);

    // read in image
    var file = imageFile;
    var contents;
    var imString;
    if (await file.exists()) {
      contents = await file.readAsBytes();
      imString = base64.encode(contents);
    }

    // db connection
    var db = Db(URL);
    await db.open();
    userCollection = db.collection(collection);

    // insert
    var current = DateTime.now().millisecondsSinceEpoch;
    var item = {"img": imString, "time": 2};
    await userCollection.insertMany([item]);

    //remove
    var item1 = {"time": 1};
    await userCollection.deleteOne(item1);

    // query
    var resultImage = false;
    var getimagetext;
    // sleep(Duration(seconds:3));
    while (!resultImage) {
      print("Sleep");
      await userCollection.find({"time": 1}).forEach((v) {
        print(v['time']);
        getimagetext = v['img'];
        resultImage = true;
      });
    }
    print("Get!");

    await db.close();
    return getimagetext;
  }
}
