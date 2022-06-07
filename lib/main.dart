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
import 'result.dart';
import 'mangodb.dart' as mango;

final Color green = Colors.green;
final Color orange = Colors.green;
late List<bool> isSelected = [true, false];

class UploadingImageToFirebaseStorage extends StatefulWidget {
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class MyImageCache extends ImageCache {
  @override
  void clear() {
    print('Clearing cache!');
    super.clear();
  }
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File? _imageFile = null;
  Image? _downloadimg = null;
  String _level = "";

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage() async {
    var pickedFile;
    if (isSelected[0]) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future uploadagain(BuildContext context) async {
    setState(() {
      MyImageCache();
      _imageFile = null;
      _downloadimg = null;
    });
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
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
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
                          child: _imageFile != null
                              ? Image.file(_imageFile!)
                              : _downloadimg != null
                                  ? _downloadimg
                                  : FlatButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Color.fromRGBO(24, 82, 20, 0.6),
                                        size: 50,
                                      ),
                                      onPressed: () {
                                        pickImage();
                                      }),
                        ),
                      ),
                    ],
                  ),
                ),
                switchButton(context),
                uploadImageButton(context),
                returnImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget switchButton(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.camera),
        Icon(Icons.perm_media),
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      borderRadius: BorderRadius.circular(30.0),
      isSelected: isSelected,
      selectedColor: Color.fromRGBO(24, 82, 20, 1),
      color: Color.fromRGBO(45, 150, 39, 0.7),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 20, left: 20.0, right: 20.0, bottom: 10.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(50, 168, 82, 0.8),
                    Color.fromRGBO(24, 82, 20, 1)
                  ],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () {
                // uploadImageToFirebase(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ResultPage(originimg: _imageFile)));
              },
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget returnImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 10, left: 20.0, right: 20.0, bottom: 30.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(50, 168, 82, 0.8),
                    Color.fromRGBO(24, 82, 20, 1)
                  ],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadagain(context),
              child: Text(
                "Upload again",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
