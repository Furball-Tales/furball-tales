import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';
import 'weight/weight_chart.dart';
import 'food/food_chart.dart';
import '../get_allPetsData.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

// var allChartData = List<Map<String, Object>> allChartData;

// _nextPage(icon, heading, textColor) {
//   if (heading == 'Weight') return Chart(allChartData);
// }

class EachJumpCard extends StatefulWidget {
  IconData icon;
  String heading;
  String petName;
  int textColor;
  int materialColor;
  double intensity;
  double depth;
  double surfaceIntensity;
  int baseColor;
  List<dynamic> allChartData;

  EachJumpCard(
    IconData icon,
    String heading,
    String petName,
    int textColor,
    int materialColor,
    double intensity,
    double depth,
    double surfaceIntensity,
    int baseColor,
    List<dynamic> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.petName = petName;
    this.textColor = textColor;
    this.materialColor = materialColor;
    this.intensity = intensity;
    this.depth = depth;
    this.surfaceIntensity = surfaceIntensity;
    this.baseColor = baseColor;
    this.allChartData = allChartData;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCardState(
      icon,
      heading,
      petName,
      textColor,
      materialColor,
      intensity,
      depth,
      surfaceIntensity,
      baseColor,
      allChartData,
    );
  }
}

class CustomCardState extends State<EachJumpCard> {
  IconData icon;
  String heading;
  String petName;
  int textColor;
  int materialColor;
  double intensity;
  double depth;
  double surfaceIntensity;
  int baseColor;
  List<dynamic> allChartData;

  var _hasPadding = false;

  CustomCardState(
    IconData icon,
    String heading,
    String petName,
    int textColor,
    int materialColor,
    double intensity,
    double depth,
    double surfaceIntensity,
    int baseColor,
    List<dynamic> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.petName = petName;
    this.textColor = textColor;
    this.materialColor = materialColor;
    this.intensity = intensity;
    this.depth = depth;
    this.surfaceIntensity = surfaceIntensity;
    this.baseColor = baseColor;
    this.allChartData = allChartData;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: petName,
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
          print(heading);
          readAllPetsData();
          // print(petName);
          setState(() {
            _hasPadding = false;
          });
          if (heading == 'Food') {
            Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) =>
                      // _nextPage(icon, heading, textColor),
                      FoodChart(heading, petName, allChartData),
                ));
          } else if (heading == 'Weight') {
            Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) =>
                      // _nextPage(icon, heading, textColor),
                      WeightChart(heading, petName, allChartData),
                ));
          }
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //text
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          petName,
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
                                  child: Icon(icon, color: Colors.grey[600]),
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
