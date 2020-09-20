import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'pet/list_card_view.dart';
import 'dashboard_jump_card.dart';
import '../sign_in.dart';
import '../frontend_settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

var mediumSkyBlue = NeumorphicCardSettings.mediumSkyBlue;
var mediumSlateBlue = NeumorphicCardSettings.mediumSlateBlue;
var brightLavender = NeumorphicCardSettings.brightLavender;
var apricot = NeumorphicCardSettings.apricot;

var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;

var caveIntensity = NeumorphicCaveSettings.caveIntensity;
var caveDepth = NeumorphicCaveSettings.caveDepth;
var caveColor = NeumorphicCaveSettings.caveColor;

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

Future updateUrl(petProfilePicUrl, petId) async {
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
  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;
  // File _image;
  final picker = ImagePicker();

  String frontGreeting;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 4) {
      frontGreeting = 'Morning';
    } else if (hour < 17) {
      frontGreeting = 'Afternoon';
    } else {
      frontGreeting = 'Evening';
    }
  }

  @override
  void initState() {
    super.initState();
    this.greeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          // Top(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: AssetImage('assets/logo.png'),
                width: 100.0,
              ),
              Center(
                child: NeumorphicText(
                  "Good ${this.frontGreeting}\n$name!",
                  style: NeumorphicStyle(
                    depth: 4,
                    color: Colors.black87,
                  ),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ListCardView().listCardView(),
          JumpCard(
            Icons.directions_run,
            "Walk",
            mediumSkyBlue,
            mediumSkyBlue,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
          JumpCard(
            Icons.note_add,
            "Memo",
            mediumSlateBlue,
            mediumSlateBlue,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
          JumpCard(
            Icons.fastfood,
            "Food",
            brightLavender,
            brightLavender,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
          JumpCard(
            Icons.pets,
            "Weight",
            apricot,
            apricot,
            intensity,
            depth,
            surfaceIntensity,
            baseColor,
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 65),
          StaggeredTile.extent(2, 230),
          StaggeredTile.extent(1, 140),
          StaggeredTile.extent(1, 140),
          StaggeredTile.extent(1, 140),
          StaggeredTile.extent(1, 140),
        ],
      ),
    );
  }
}
