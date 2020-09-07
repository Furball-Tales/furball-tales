import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

// class Photos extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ImageGridItem(),
//     );
//   }
// }

class Photos extends StatefulWidget {
  String _albumName;

  Photos(String albumName) {
    this._albumName = albumName;
  }

  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  final databaseReference =
      FirebaseDatabase.instance.reference().child("images");

  List<String> photoList = List<String>();

  getAlbums() {
    databaseReference
        .child('Ryohei Mizuho')
        .child('${widget._albumName}')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> albums = snapshot.value;
      albums.forEach((k, v) {
        if (k != null) {
          photoList.add(k.imageData);
          print(photoList);
        }
      });
    });
  }

  // Uint8List imageFile;
  // StorageReference photosReference =
  //     FirebaseStorage.instance.ref().child("Photos");

  // getImage() {
  //   int MAX_SIZE = 7 * 1024 * 1024;
  //   photosReference
  //       .child("image_${widget._index}.jpg")
  //       .getData(MAX_SIZE)
  //       .then((data) {
  //     this.setState(() {
  //       imageFile = data;
  //     });
  //   }).catchError((onError) {});
  // }

  Widget decideGridTileView() {
    if (photoList.length == 0) {
      return Center(child: Text("Loading"));
    } else {
      return GridView.builder(
          itemCount: photoList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final album = photoList[index];
            return GestureDetector(
              child: Card(
                elevation: 5.0,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('$album'),
                ),
              ),
              // onTap: () {
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
