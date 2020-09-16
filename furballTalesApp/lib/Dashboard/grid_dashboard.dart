import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'pet/list_card_view.dart';
import 'dashboard_jump_card.dart';
import '../sign_in.dart';
import '../frontend_settings.dart';
// import '../initial_registration.dart';
import '../get_allPetsData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: GridDashboard(),
    );
  }
}

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

var baseColor = NeumorphicCardSettings.baseColor;

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var accentGold = NeumorphicCardSettings.accentGold;

var mildBlueGreen = NeumorphicCardSettings.mildBlueGreen;
var mildBlue = NeumorphicCardSettings.mildBlue;
var mildDarkBlue = NeumorphicCardSettings.mildDarkBlue;

var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;

var caveIntensity = NeumorphicCaveSettings.caveIntensity;
var caveDepth = NeumorphicCaveSettings.caveDepth;
var caveColor = NeumorphicCaveSettings.caveColor;

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

// var _url;
// var _name;
// var _sex;
// var _age;
// var _petId;

// Future readPetdata() async {
//   var readData;
//   await databaseReference.once().then((DataSnapshot snapshot) {
//     snapshot.value.forEach((index, data) => {_petId = index, readData = data});
//   });
//   _name = await readData["petName"];
//   _sex = await readData["sex"];
//   var readBirthday = await readData["birthday"];
//   DateTime birthday = DateTime.parse(readBirthday);
//   Duration differenceDays = DateTime.now().difference(birthday);
//   _age = (differenceDays.inDays / 365).floor().toString();
//   // _weight = await readData["weight"];
// }

// Future readUrl() async {
//   var readData;
//   await databaseReference.once().then((DataSnapshot snapshot) {
//     snapshot.value.forEach((index, data) => {readData = data});
//   });
//   _url = await readData["petProfilePicUrl"];
// }

Future updateUrl(petProfilePicUrl, petId) async {
  // var key = allPetsData[0]['key'];
  // print("======key: $key");
  // var readIndex;
  // await databaseReference.once().then((DataSnapshot snapshot) {
  //   snapshot.value.forEach((index, data) => {readIndex = index});
  // });
  databaseReference.child(petId).update({'petProfilePicUrl': petProfilePicUrl});
}

Future<String> uploadImage(var imageFile, petId) async {
  print("petId: $petId");
  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child('$id')
      .child("profileImages")
      .child('$petId')
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

class _GridDashboardState extends State<GridDashboard> {
  // File _image;
  final picker = ImagePicker();

  // Future selectImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   _image = File(pickedFile.path);

  //   var uploadUrl = await uploadImage(_image, _petId);
  //   updateUrl(uploadUrl);
  //   await readUrl();

  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // readAllPetsData();
    // readPetdata();
    // readUrl();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          // Top(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeumorphicText(
                "  Good Morning,\n$name.",
                style: NeumorphicStyle(
                  depth: 4, //customize depth here
                  color: Colors.white, //customize color here
                ),
                textStyle: NeumorphicTextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold //customize size here
                    // AND others usual text style properties (fontFamily, fontWeight, ...)
                    ),
              ),
            ],
          ),
          ListCardView().listCardView(),
          JumpCard(
            Icons.directions_run,
            "Walk",
            mildBlueGreen,
            mildBlueGreen,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
          JumpCard(
            Icons.color_lens,
            "Food",
            mildBlue,
            mildBlue,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
          JumpCard(
            Icons.wb_sunny,
            "Weight",
            mildDarkBlue,
            mildDarkBlue,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 65),
          StaggeredTile.extent(2, 230),
          StaggeredTile.extent(2, 140),
          StaggeredTile.extent(1, 140),
          StaggeredTile.extent(1, 140),
        ],
      ),
    );
  }

  // Material Top() {
  //   return Material(
  //     color: Colors.transparent,
  //     child: Neumorphic(
  //       style: NeumorphicStyle(
  //         shape: NeumorphicShape.concave,
  //         surfaceIntensity: surfaceIntensity,
  //         depth: depth,
  //         intensity: intensity,
  //         lightSource: LightSource.topLeft,
  //         color: Color(baseColor),
  //       ),
  //       child: Row(
  //         children: <Widget>[
  //           GestureDetector(
  //             onTap: () {
  //               selectImage();
  //             },
  //             child: Padding(
  //                 padding: const EdgeInsets.all(40.40),
  //                 child: StreamBuilder(
  //                     stream: databaseReference.onValue,
  //                     builder: (context, snap) {
  //                       return (_url != null)
  //                           ? Container(
  //                               width: 115.0,
  //                               height: 115.0,
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   image: DecorationImage(
  //                                     fit: BoxFit.fill,
  //                                     image: NetworkImage(_url),
  //                                   )))
  //                           : Container(
  //                               width: 115.0,
  //                               height: 115.0,
  //                               decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   image: DecorationImage(
  //                                     fit: BoxFit.fill,
  //                                     image: NetworkImage(
  //                                         "https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347"),
  //                                   )));
  //                     })),
  //           ),
  //           Flexible(
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.10),
  //                   child: Padding(
  //                     padding: EdgeInsets.only(left: 8),
  //                     child: NeumorphicText(
  //                       "Good Morning",
  //                       style: NeumorphicStyle(
  //                         depth: 4, //customize depth here
  //                         color: Colors.white, //customize color here
  //                       ),
  //                       textStyle: NeumorphicTextStyle(
  //                           fontSize: 27,
  //                           fontWeight: FontWeight.bold //customize size here
  //                           // AND others usual text style properties (fontFamily, fontWeight, ...)
  //                           ),
  //                     ),
  //                   ),
  //                 ),
  //                 Neumorphic(
  //                   style: NeumorphicStyle(
  //                       shape: NeumorphicShape.concave,
  //                       // boxShape: NeumorphicBoxShape.roundRect(
  //                       //     borderRadius: BorderRadius.circular(12)),
  //                       depth: caveDepth,
  //                       intensity: caveIntensity,
  //                       lightSource: LightSource.topLeft,
  //                       color: Color(caveColor)),
  //                   child: Container(
  //                     color: Colors.transparent,
  //                     height: 100,
  //                     width: 130,
  //                     child: Padding(
  //                       padding: EdgeInsets.only(left: 12, bottom: 12),
  //                       child: StreamBuilder(
  //                           stream: databaseReference.onValue,
  //                           builder: (context, snap) {
  //                             return Column(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: <Widget>[
  //                                 SizedBox(
  //                                   height: 4,
  //                                 ),
  //                                 Text('Name: $_name'),
  //                                 Text('Sex: $_sex'),
  //                                 Text('Age: $_age'),
  //                                 // Text('Weight: $_weight'),
  //                               ],
  //                             );
  //                           }),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
}
