import 'package:flutter/material.dart';
// import '../../main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../grid_dashboard.dart';
import '../../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var textBaseColor = NeumorphicCardSettings.textBaseColor;

class PetDetail extends StatelessWidget {
  String heroTag;
  String birthday;
  String name;
  String photo;
  String sex;

  PetDetail(
    String heroTag,
    String birthday,
    String name,
    String photo,
    String sex,
  ) {
    this.heroTag = heroTag;
    this.birthday = birthday;
    this.name = name;
    this.photo = photo;
    this.sex = sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, //Make background of overall Widget transparent
      body: Hero(
        tag: heroTag,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            color: Color(baseColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InkResponse(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                                FlatButton(
                                  child: Icon(Icons.update),
                                  onPressed: () {},
                                )
                              ],
                              title: Text("Edit pet photo?"),
                            );
                          });
                    },
                    child: Container(
                      height: 300,
                      child: imageContents(context),
                    ),
                  ),
                ),
                Expanded(
                  child: InkResponse(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                                FlatButton(
                                  child: Icon(Icons.update),
                                  onPressed: () {},
                                )
                              ],
                              title: Text("Edit pet information?"),
                            );
                          });
                    },
                    child: Container(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 16.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    depth: caveDepth,
                                    intensity: caveIntensity,
                                    lightSource: LightSource.topLeft,
                                    color: Color(caveColor)),
                                child: Container(
                                  color: Colors.transparent,
                                  height: 120,
                                  width: 240,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                        left: 20,
                                        right: 20,
                                        bottom: 5,
                                      ),
                                      child: StreamBuilder(
                                        stream: databaseReference.onValue,
                                        builder: (context, snap) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 3,
                                                    bottom: 20,
                                                  ),
                                                  child: Text(
                                                    name,
                                                    style: TextStyle(
                                                      color:
                                                          Color(textBaseColor),
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                right: 8),
                                                        child: Text(
                                                          sex,
                                                          style: TextStyle(
                                                            color: Color(
                                                                textBaseColor),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 4),
                                                        child: Text(
                                                          birthday + ' yrs',
                                                          style: TextStyle(
                                                            color: Color(
                                                                textBaseColor),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
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
              child: Image.network(
                photo,
                fit: BoxFit.cover,
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
