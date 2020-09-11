import 'package:flutter/material.dart';
import '../main.dart';
import '../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;

class FoodDetail extends StatelessWidget {
  IconData icon;
  String heading;
  int color;

  FoodDetail(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Color(baseColor), //Make background of overall Widget transparent
        body: Hero(
            tag: heading,
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
                            color: Color(0xff00b8d4),
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
