import 'package:flutter/material.dart';
import '../../frontend_settings.dart';
import '../each_jump_card.dart';

var baseColor = NeumorphicCardSettings.baseColor;

var mildBlueGreen = NeumorphicCardSettings.mildBlueGreen;
var mildBlue = NeumorphicCardSettings.mildBlue;
var mildDarkBlue = NeumorphicCardSettings.mildDarkBlue;

class Test extends StatelessWidget {
  IconData icon;
  String heading;
  int textColor;
  int materialColor;
  double intensity;
  double depth;
  double surfaceIntensity;
  int baseColor;

  Test(IconData icon, String heading, int textColor, int materialColor,
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
  Widget build(BuildContext context) {
    return EachJumpCard(
      Icons.directions_run,
      "Pet Name1",
      mildBlueGreen,
      mildBlueGreen,
      intensity,
      depth,
      surfaceIntensity,
      baseColor,
    );
  }
}
