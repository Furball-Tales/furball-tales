import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';
import '../sign_in.dart';
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

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.light,
//       title: 'Flutter Neumorphic',
//       home: Albums(),
//     );
//   }
// }

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
  final storageReference =
      FirebaseStorage.instance.ref().child("$id").child("images");

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
        'null',
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
                      NeumorphicTheme(
                        child: NeumorphicButton(
                          child: const Text('Add'),
                          onPressed: () {
                            createAlbum();
                            Navigator.of(context).pop();
                          },
                          style: NeumorphicStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Text("Add Album"),
                    content:
                        Stack(overflow: Overflow.visible, children: <Widget>[
                      Form(
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                maxLength: 20,
                                onChanged: (String _newAlbumValue) {
                                  newAlbumName = _newAlbumValue;
                                },
                                decoration: InputDecoration(labelText: 'Album'),
                              ),
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
                                          if (data[item[index]["key"]]
                                                  ['pictures'] !=
                                              null) {
                                            List<Map<String, dynamic>>
                                                dummyListMap = new List();
                                            data[item[index]["key"]]['pictures']
                                                .forEach((key, mapValue) {
                                              dummyListMap.add(
                                                  Map<String, dynamic>.from(
                                                      mapValue));
                                            });
                                            dummyListMap.forEach((key) {
                                              storageReference
                                                  .child(
                                                      key["imgName"].toString())
                                                  .delete();
                                            });
                                          }
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
                  return Center(child: Text("No Albums"));
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
            Flexible(
              child: Column(
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
              ),
            )
          ],
        ),
      ),
    ),
  );
}
