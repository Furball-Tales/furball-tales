import 'package:flutter/material.dart';
import 'food_detail_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FoodCard extends StatefulWidget {
  IconData icon;
  String heading;
  int color;

  FoodCard(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCardState(icon, heading, color);
  }
}

class CustomCardState extends State<FoodCard> {
  IconData icon;
  String heading;
  int color;
  var _hasPadding = false;

  CustomCardState(IconData icon, String heading, int color) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: heading,
      child: Material(
        type: MaterialType.transparency,
        child: content(),
      ),
    );
  }

  Widget content() {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 80),
      padding: EdgeInsets.all(_hasPadding ? 10 : 0),
      child: GestureDetector(
        onTapDown: (TapDownDetails downDetails) {
          setState(() {
            _hasPadding = true;
          });
        },
        onTap: () {
          print('Card tapped.');
          setState(() {
            _hasPadding = false;
          });
          Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) =>
                    FoodDetailPage(icon, heading, color),
              ));
        },
        onTapCancel: () {
          setState(() {
            _hasPadding = false;
          });
        },
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              surfaceIntensity: 0.1,
              depth: 1.5,
              intensity: 0.7,
              lightSource: LightSource.topLeft,
              color: Colors.grey[200]),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //text
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          heading,
                          style: TextStyle(
                            color: Color(color),
                            fontSize: 20,
                          ),
                        ),
                      ),

                      //icon
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
                                  top: 8.0,
                                  child: Icon(icon, color: Colors.grey[600]),
                                ),
                                Icon(
                                  icon,
                                  color: Colors.white,
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
        ),
      ),
    );
  }
}

//  Material MyItems(IconData icon, String heading, int color) {
//     return Material(
//       color: Colors.white,
//       elevation: 14.0,
//       shadowColor: Colors.grey[200],
//       borderRadius: BorderRadius.circular(60),

//     );
//   }
