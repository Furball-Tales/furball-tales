import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './memo.dart';
import 'custom_card.dart';
import 'food_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

var accentBlue = 0xff00b8d4;
var accentPink = 0xffD41571;
var accentYellow = 0xffD4BF15;

final databaseReference = FirebaseDatabase.instance
    .reference()
    .child('pets')
    .child("Ryohei Mizuho")
    .child("1");

var _url;

Future readUrl() async {
  var url;
  await databaseReference.once().then((DataSnapshot snapshot) {
    url = snapshot.value;
  });
  _url = await url["petProfilePic"];
  // return await url["petProfilePic"];
}

void updateUrl(imageData) {
  databaseReference.update({'petProfilePic': imageData});
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
    // final currentUser = await FirebaseAuth.instance.currentUser();
    // print(currentUser);
    // StorageReference ref = FirebaseStorage.instance.ref().child("/beach.jpg");
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("images")
        .child(basename(imageFile.path));
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
    // _url = await readUrl();
    await readUrl();

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          FoodCard(Icons.graphic_eq, "Food", accentBlue),
          cardPageView(),
          MyItems(Icons.graphic_eq, "Walk", accentPink),
          MyItems(Icons.graphic_eq, "Goods", accentYellow),
          MyItems(Icons.graphic_eq, "Clothes", accentYellow),
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

  Widget MyItems(IconData icon, String heading, int color) {
    return Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          // boxShape: NeumorphicBoxShape.roundRect(
          //     borderRadius: BorderRadius.circular(12)),
          depth: 8,
          intensity: 0.5,
          lightSource: LightSource.topLeft,
          color: Colors.grey[100]),
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
                        color: Color(color),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
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
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            // boxShape: NeumorphicBoxShape.roundRect(
            //     borderRadius: BorderRadius.circular(12)),
            depth: 8,
            intensity: 0.5,
            lightSource: LightSource.topLeft,
            color: Colors.grey[100]),
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
                        return Container(
                            width: 115.0,
                            height: 115.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(_url),
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
                      child: Text(
                        'Good Morning, Sir.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.cyanAccent[700],
                        ),
                      ),
                    ),
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        // boxShape: NeumorphicBoxShape.roundRect(
                        //     borderRadius: BorderRadius.circular(12)),
                        depth: -3,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey[100]),
                    child: Container(
                      color: Colors.transparent,
                      height: 100,
                      width: 130,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 4,
                            ),
                            Text('Name: Benjamin'),
                            Text('Sex: ♂'),
                            Text('Age: 3 months'),
                          ],
                        ),
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
              // 間隔が狭くなるので若干marginを付けてあげる
              margin: EdgeInsets.only(right: 10, bottom: 20),
              child: CustomCard(itemList[i], photoList[i]),
            )
        ],
      ),
    );
  }
}
