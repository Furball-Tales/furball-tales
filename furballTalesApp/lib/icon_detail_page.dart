import 'package:flutter/material.dart';
import 'main.dart';

class IconDetailPage extends StatelessWidget {
  IconData icon;
  String heading;
  int color;

  IconDetailPage(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Colors.transparent, //Make background of overall Widget transparent
        body: Hero(
            tag: "iconTag",
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 300,
                          child: imageContents(context),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 500,
                          child: Text('content'),
                        ),
                      )
                    ],
                  ),
                ))));
  }

  // Image Widget
  Widget imageContents(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        height: 277,
        color: Colors.white,
        child: Container(
            child: Stack(
          children: <Widget>[
            Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: statusBarHeight),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Container(
                          child: RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                            shape: CircleBorder(),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }),
                              );
                            },
                          ),
                        )
                      ]),
                )
              ],
            )
          ],
        )));
  }
}
