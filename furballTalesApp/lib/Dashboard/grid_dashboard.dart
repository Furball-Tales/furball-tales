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
var apricot = NeumorphicCardSettings.apricot;
var brightLavender = NeumorphicCardSettings.brightLavender;
var pastelMagenta = NeumorphicCardSettings.pastelMagenta;

var textBaseColor = NeumorphicCardSettings.textBaseColor;

var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;

var caveIntensity = NeumorphicCaveSettings.caveIntensity;
var caveDepth = NeumorphicCaveSettings.caveDepth;
var caveColor = NeumorphicCaveSettings.caveColor;

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');
final databaseReferencePetinfo =
    FirebaseDatabase.instance.reference().child('$id').child('petinfo');

Future updateUrl(petProfilePicUrl, petId) async {
  databaseReference.child(petId).update({'petProfilePicUrl': petProfilePicUrl});
  databaseReferencePetinfo
      .child(petId)
      .update({'petProfilePicUrl': petProfilePicUrl});
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

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(brightLavender), Color(pastelMagenta)],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    this.greeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 310,
              child: StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 25.0,
                mainAxisSpacing: 0.0,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                children: <Widget>[
                  // Top(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 21, top: 18, right: 15, bottom: 10),
                        child: Text(
                          "Good ${this.frontGreeting}\n$name!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                              foreground: Paint()..shader = linearGradient),
                          // depth: 4,
                          // color: Color(textBaseColor),
                        ),
                        // textStyle: NeumorphicTextStyle(
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.bold,
                        //   height: 1.4,
                        // ),
                      ),
                    ],
                  ),
                  ListCardView().listCardView(),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 90),
                  StaggeredTile.extent(2, 210),
                ],
              ),
            ),
            SizedBox(
              height: 320,
              child: StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 26.0,
                mainAxisSpacing: 28.0,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                children: <Widget>[
                  // Top(),
                  JumpCard(
                    Icons.directions_run,
                    "Walk",
                    pastelMagenta,
                    pastelMagenta,
                    intensity,
                    depth,
                    surfaceIntensity,
                    baseColor,
                  ),
                  JumpCard(
                    Icons.note_add,
                    "Memo",
                    brightLavender,
                    brightLavender,
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
                    pastelMagenta,
                    pastelMagenta,
                    intensity,
                    depth,
                    surfaceIntensity,
                    baseColor,
                  ),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(1, 120),
                  StaggeredTile.extent(1, 120),
                  StaggeredTile.extent(1, 120),
                  StaggeredTile.extent(1, 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
