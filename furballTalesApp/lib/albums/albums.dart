import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';
import '../sign_in.dart';
import '../Dashboard/grid_dashboard.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../app_bar.dart';

class Albums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageGridItem(),
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
      body: Column(
        children: [
          InkWell(
              onTap: () {
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
                                      surfaceIntensity: 0.2,
                                      depth: 1.5,
                                      intensity: 5,
                                      lightSource: LightSource.topLeft,
                                      color: Colors.grey[200]),
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
                        content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
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
                                          decoration: InputDecoration(
                                              labelText: 'Album')),
                                    )
                                  ])))
                            ]));
                  },
                );
              },
              child: Container(
                  margin: EdgeInsets.all(8),
                  width: 200,
                  child: Neumorphic(
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          surfaceIntensity: 0.2,
                          depth: 1.5,
                          intensity: 5,
                          lightSource: LightSource.topLeft,
                          color: Colors.grey[200]),
                      child: ListTile(
                        leading: Icon(
                          Icons.photo_album,
                          size: 45,
                          color: Colors.pink[400],
                        ),
                        title: Text(
                          'Add Album',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )))),
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
                        child: MyItems(Icons.photo_library,
                            item[index]["albumNames"], accentPink),
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
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: -10,
                        blurRadius: 17,
                        offset: Offset(-5, -5),
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(7, 7),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Color(color),
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
                            color: Colors.grey[200],
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
