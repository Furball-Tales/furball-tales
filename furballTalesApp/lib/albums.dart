import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'photos.dart';
import 'sign_in.dart';

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
  TextEditingController _txtCtrl = TextEditingController();

  createAlbum() {
    databaseReference.push().set({
      "message": _txtCtrl.text,
      "timestamp": DateTime.now().millisecondsSinceEpoch
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
    return StreamBuilder(
      stream: databaseReference.onValue,
      builder: (context, snap) {
        if (snap.hasData &&
            !snap.hasError &&
            snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          List item = [];

          data.forEach((index, data) => item.add({"key": index, ...data}));
          print(item);
          return ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("item[index]"),
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
          return Text("No data");
      },
    );
    ;
  }
}
