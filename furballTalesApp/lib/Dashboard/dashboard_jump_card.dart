import 'package:flutter/material.dart';
import 'food/food_detail.dart';
import 'walk/walk_detail.dart';
import 'weight/weight_detail.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

_nextPage(icon, heading, textColor) {
  if (heading == 'Food') return FoodDetail(icon, heading, textColor);
  if (heading == 'Walk') return WalkDetail(icon, heading, textColor);
  if (heading == 'Food') return FoodDetail(icon, heading, textColor);
  if (heading == 'Weight') return WeightDetail(icon, heading, textColor);
}

class JumpCard extends StatefulWidget {
  IconData icon;
  String heading;
  int textColor;
  int materialColor;
  double intensity;
  double depth;
  double surfaceIntensity;
  int baseColor;

  JumpCard(IconData icon, String heading, int textColor, int materialColor,
      double intensity, double depth, double surfaceIntensity, int baseColor) {
    this.icon = icon;
    this.heading = heading;
    this.textColor = textColor;
    this.materialColor = materialColor;
    this.intensity = intensity;
    this.depth = depth;
    this.surfaceIntensity = surfaceIntensity;
    this.baseColor = baseColor;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCardState(icon, heading, textColor, materialColor, intensity,
        depth, surfaceIntensity, baseColor);
  }
}

class CustomCardState extends State<JumpCard> {
  IconData icon;
  String heading;
  int textColor;
  int materialColor;
  double intensity;
  double depth;
  double surfaceIntensity;
  int baseColor;

  var _hasPadding = false;

  CustomCardState(
      IconData icon,
      String heading,
      int textColor,
      int materialColor,
      double intensity,
      double depth,
      double surfaceIntensity,
      int baseColor) {
    this.icon = icon;
    this.heading = heading;
    this.textColor = textColor;
    this.materialColor = materialColor;
    this.intensity = intensity;
    this.depth = depth;
    this.surfaceIntensity = surfaceIntensity;
    this.baseColor = baseColor;
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
                    _nextPage(icon, heading, textColor),
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
              surfaceIntensity: surfaceIntensity,
              depth: depth,
              intensity: intensity,
              lightSource: LightSource.topLeft,
              color: Color(baseColor)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //text
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              heading,
                              style: TextStyle(
                                color: Color(textColor),
                                fontSize: 20,
                              ),
                            ),
                          ),

                          //icon
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
                                      right: 0.5,
                                      top: 8.0,
                                      child:
                                          Icon(icon, color: Colors.grey[600]),
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
                    ),
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
