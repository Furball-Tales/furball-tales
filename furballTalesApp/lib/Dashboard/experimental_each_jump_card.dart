import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';
import 'weight/weight_chart.dart';
import 'food/food_chart.dart';
import '../get_allPetsData.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

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

  // var foodData =

  var data = [
    0.0,
    1.0,
    1.5,
    2.0,
    0.0,
    0.0,
    -0.5,
    -1.0,
    -0.5,
    0.0,
    0.0,
    0.0,
    1.0,
    1.5,
    2.0,
    0.0,
    0.0,
    -0.5,
    -1.0,
    -0.5,
    0.0,
    0.0,
    1.5,
    2.0,
    0.0,
    0.0,
    -0.5,
    -1.0,
    -0.5,
    0.0,
    0.0
  ];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  Material mychart1Items() {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //text
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          petName,
                          style: TextStyle(
                            color: Color(textColor),
                            fontSize: 20,
                          ),
                        ),
                      ),

                      //icon
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: mychart1Items(),
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
