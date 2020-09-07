import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';

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
      FirebaseDatabase.instance.reference().child("images");

  List<String> albumList = List<String>();

  getAlbums() {
    databaseReference
        .child('Ryohei Mizuho')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> albums = snapshot.value;
      albums.forEach((k, v) {
        albumList.add(k);
        print(albumList);
      });
    });
  }

  Widget decideGridTileView() {
    if (albumList.length == 0) {
      return Center(child: Text("Loading"));
    } else {
      return GridView.builder(
          itemCount: albumList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final album = albumList[index];
            return GestureDetector(
              child: Card(
                elevation: 5.0,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('$album'),
                ),
              ),
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
            );
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return decideGridTileView();
  }
}
