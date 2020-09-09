import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './memo.dart';
import 'custom_card.dart';
import 'food_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../sign_in.dart';

import 'package:firebase_storage/firebase_storage.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

var accentBlue = 0xff00E5FF;
var accentPink = 0xffFF1996;
var accentYellow = 0xffFFE319;

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

var _url;
var _name;
var _sex;
var _age;
var _weight;

Future readPetdata() async {
  var readData;
  await databaseReference.once().then((DataSnapshot snapshot) {
    snapshot.value.forEach((index, data) => {readData = data});
  });
  _name = await readData["petName"];
  _sex = await readData["sex"];
  var readBirthday = await readData["birthday"];
  DateTime birthday = DateTime.parse(readBirthday);
  Duration differenceDays = DateTime.now().difference(birthday);
  _age = (differenceDays.inDays / 365).floor().toString();
  _weight = await readData["weight"];
}

Future readUrl() async {
  var readData;
  await databaseReference.once().then((DataSnapshot snapshot) {
    snapshot.value.forEach((index, data) => {readData = data});
  });
  _url = await readData["petProfilePicUrl"];
}

Future updateUrl(petProfilePicUrl) async {
  var readIndex;
  await databaseReference.once().then((DataSnapshot snapshot) {
    snapshot.value.forEach((index, data) => {readIndex = index});
  });
  databaseReference
      .child(readIndex)
      .update({'petProfilePicUrl': petProfilePicUrl});
}

class _GridDashboardState extends State<GridDashboard> {
  var itemList = ['one', 'two', 'three', 'for', 'five'];
  var photoList = [
    'assets/top_image.png',
    'assets/logo.png',
    'assets/google_logo.png',
    'assets/login_background.png',
    'assets/top_image.png',
  ];
  File _image;
  final picker = ImagePicker();

  Future<String> uploadImage(var imageFile) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('$id')
        .child("profileImage")
        .child("profileImage.jpg");
    StorageUploadTask uploadTask =
        ref.putFile(imageFile, StorageMetadata(contentType: 'image/jpeg'));
    final snapshot = await uploadTask.onComplete;
    var downUrl;
    if (snapshot.error == null) {
      downUrl = await snapshot.ref.getDownloadURL();
    } else {
      print(snapshot.error);
      downUrl = null;
    }
    String url = downUrl.toString();

    return url;
  }

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    var uploadUrl = await uploadImage(_image);
    updateUrl(uploadUrl);
    await readUrl();

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    readPetdata();
    readUrl();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          Top(),
          FoodCard(Icons.fastfood, "Food", accentBlue),
          cardPageView(),
          MyItems(Icons.directions_run, "Walk", accentPink, accentPink),
          MyItems(Icons.color_lens, "Goods", 0xffD4BF15, accentYellow),
          MyItems(Icons.wb_sunny, "Clothes", 0xffD4BF15, accentYellow),
          // Memo(),
        ],
        staggeredTiles: [
          StaggeredTile.fit(2),
          StaggeredTile.extent(1, 200),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(2, 140),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),
        ],
      ),
    );
  }

  Widget MyItems(
      IconData icon, String heading, int textColor, int materialColor) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          surfaceIntensity: 0.1,
          depth: 8,
          intensity: 0.8,
          lightSource: LightSource.topLeft,
          color: Colors.grey[300]),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: Color(textColor),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.white,
                    //       spreadRadius: -10,
                    //       blurRadius: 17,
                    //       offset: Offset(-5, -5),
                    //     ),
                    //     BoxShadow(
                    //       color: Colors.black26,
                    //       spreadRadius: -2,
                    //       blurRadius: 10,
                    //       offset: Offset(7, 7),
                    //     ),
                    //   ],
                    // ),
                    child: Material(
                      color: Color(materialColor),
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              right: 0.5,
                              top: 6.0,
                              child: Icon(icon, color: Colors.grey[600]),
                            ),
                            Icon(
                              icon,
                              color: Colors.grey[100],
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Material Top() {
    return Material(
      color: Colors.transparent,
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            surfaceIntensity: 0.1,
            depth: 8,
            intensity: 0.8,
            lightSource: LightSource.topLeft,
            color: Colors.grey[300]),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Padding(
                  padding: const EdgeInsets.all(40.40),
                  child: StreamBuilder(
                      stream: databaseReference.onValue,
                      builder: (context, snap) {
                        return (_url != null)
                            ? Container(
                                width: 115.0,
                                height: 115.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(_url),
                                    )))
                            : Container(
                                width: 115.0,
                                height: 115.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347"),
                                    )));
                      })),
            ),
            Flexible(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.10),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: NeumorphicText(
                        "Good Morning",
                        style: NeumorphicStyle(
                          depth: 4, //customize depth here
                          color: Colors.white, //customize color here
                        ),
                        textStyle: NeumorphicTextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold //customize size here
                            // AND others usual text style properties (fontFamily, fontWeight, ...)
                            ),
                      ),
                      // child: Text(
                      //   'Good Morning 😍',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 20,
                      //     color: Colors.cyanAccent[700],
                      //   ),
                      // ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        // boxShape: NeumorphicBoxShape.roundRect(
                        //     borderRadius: BorderRadius.circular(12)),
                        depth: -3,
                        intensity: 0.7,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey[200]),
                    child: Container(
                      color: Colors.transparent,
                      height: 100,
                      width: 130,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, bottom: 12),
                        child: StreamBuilder(
                            stream: databaseReference.onValue,
                            builder: (context, snap) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text('Name: $_name'),
                                  Text('Sex: $_sex'),
                                  Text('Age: $_age'),
                                  Text('Weight: $_weight'),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardPageView() {
    return Container(
      height: 315,
      child: PageView(
        // store this controller in a State to save the carousel scroll position
        controller: PageController(viewportFraction: 0.8),
        children: <Widget>[
          for (var i = 0; i < itemList.length; i++)
            Container(
              // giving some mergin
              margin: EdgeInsets.only(right: 10, bottom: 20),
              child: CustomCard(itemList[i], photoList[i]),
            )
        ],
      ),
    );
  }
}
