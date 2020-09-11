import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';
import '../sign_in.dart';
import '../Dashboard/grid_dashboard.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: Albums(),
    );
  }
}

_buildButton({String text, int color, VoidCallback onClick}) =>
    BuildButton().buildButton;

class Albums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageGridItem(),
      backgroundColor: Color(baseColor),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("$id").child("albums");
  // FirebaseDatabase.instance.reference().child("images");

  var newAlbumName = "";

  createAlbum() {
    databaseReference.push().set({
      "albumNames": newAlbumName,
    }).whenComplete(() {
      print("Album created");
    });
  }

  deleteAlbum(key) {
    databaseReference.child(key).remove();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  List<String> albumList = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: GradientAppBar(
        "Albums",
        false,
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: NeumorphicTheme(
        child: NeumorphicFloatingActionButton(
          child: Container(
            color: Color(baseColor),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    actions: <Widget>[
                      Container(
                          margin: EdgeInsets.all(8),
                          width: 130,
                          child: Neumorphic(
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  surfaceIntensity: surfaceIntensity,
                                  depth: depth,
                                  intensity: intensity,
                                  lightSource: LightSource.topLeft,
                                  color: Color(baseColor)),
                              child: FlatButton(
                                  onPressed: () {
                                    createAlbum();
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.photo_album,
                                        size: 25,
                                        color: Colors.pink[400],
                                      ),
                                      Text(
                                        "Add Album",
                                        style: TextStyle(
                                            fontFamily: 'BalooBhai',
                                            fontSize: 17.0),
                                      )
                                    ],
                                  ))))
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Text("Add Album"),
                    content:
                        Stack(overflow: Overflow.visible, children: <Widget>[
                      Positioned(
                        right: -50.0,
                        top: -50.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                      Form(
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                  onChanged: (String _newAlbumValue) {
                                    newAlbumName = _newAlbumValue;
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'Album')),
                            )
                          ])))
                    ]));
              },
            );
          },
          tooltip: 'New Album',
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snap) {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data.snapshot.value != null) {
                  Map data = snap.data.snapshot.value;
                  List item = [];

                  data.forEach(
                      (index, data) => item.add({"key": index, ...data}));

                  return GridView.builder(
                    itemCount: item.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) {
                      return GridTile(
                          child: InkResponse(
                        enableFeedback: true,
                        child: MyItems(
                          Icons.photo_library,
                          item[index]["albumNames"],
                          accentPink,
                          accentPink,
                          intensity,
                          depth,
                          surfaceIntensity,
                          baseColor,
                        ),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Photos(item[index]['key'])))
                        },
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          String key = item[index]['key'];
                                          databaseReference
                                              .child('$key')
                                              .remove();
                                          Navigator.of(context).pop();
                                        });
                                        _showScaffold("Deleted Album");
                                      },
                                    )
                                  ],
                                  title: Text("Delete Album?"),
                                );
                              });
                        },
                      ));
                    },
                  );
                } else
                  return Text("No Albums");
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget MyItems(
  IconData icon,
  String heading,
  int textColor,
  int materialColor,
  double intensity,
  double depth,
  double surfaceIntensity,
  int baseColor,
) {
  return Neumorphic(
    style: NeumorphicStyle(
      shape: NeumorphicShape.concave,
      surfaceIntensity: surfaceIntensity,
      depth: depth,
      intensity: intensity,
      lightSource: LightSource.topLeft,
      color: Color(baseColor),
    ),
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
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Color(materialColor),
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            right: -2.5,
                            top: 7.0,
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
