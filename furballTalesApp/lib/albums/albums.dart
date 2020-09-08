import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';
import '../sign_in.dart';

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

  List<String> albumList = List<String>();

  // getAlbums() {
  //   databaseReference
  //       .child('Ryohei Mizuho')
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     Map<dynamic, dynamic> albums = snapshot.value;
  //     albums.forEach((k, v) {
  //       albumList.add(k);
  //       print(albumList);
  //     });
  //   });
  // }

  // Widget decideGridTileView() {
  //   if (albumList.length == 0) {
  //     return Center(child: Text("Loading"));
  //   } else {
  //     return GridView.builder(
  //         itemCount: albumList.length,
  //         gridDelegate:
  //             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //         itemBuilder: (context, index) {
  //           final album = albumList[index];
  //           return GestureDetector(
  //             child: Card(
  //               elevation: 5.0,
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 child: Text('$album'),
  //               ),
  //             ),
  // onTap: () {
  // Photos(album);
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     child: new CupertinoAlertDialog(
  //       title: new Column(
  //         children: <Widget>[
  //           new Text("GridView"),
  //           new Icon(
  //             Icons.favorite,
  //             color: Colors.green,
  //           ),
  //         ],
  //       ),
  //       content: new Text("Selected Item $index"),
  //       actions: <Widget>[
  //         new FlatButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: new Text("OK"))
  //       ],
  //     ),
  //   );
  // },
  //           );
  //         });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // getAlbums();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            createAlbum();
                            Navigator.of(context).pop();
                          },
                          child: Text("Add Album"))
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
          child: Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.teal[900],
                ),
                title: Text(
                  'About',
                  style: TextStyle(fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
              )),
        ),
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
                print(item);
                return GridView.builder(
                  itemCount: item.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Text(item[index]["albumNames"]),
                      // trailing: Text(DateFormat("hh:mm:ss")
                      //     .format(DateTime.fromMicrosecondsSinceEpoch(
                      //         item[index]['timestamp'] * 1000))
                      //     .toString()),
                      // onTap: () => updateTimeStamp(item[index]['key']),
                      // onLongPress: () => deleteMessage(item[index]['key']),
                    );
                  },
                );
              } else
                return Text("No Albums");
            },
          ),
        ),
      ],
    );
  }
}
