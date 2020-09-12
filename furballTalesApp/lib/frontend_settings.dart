import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCardSettings {
  //Color Settings
  static int accentBlue = 0xff00E5FF;
  static int accentPink = 0xffFF1996;
  static int accentYellow = 0xffFFE319;
  static int accentGold = 0xffD4BF15;

  static int mildBlueGreen = 0xff2ecaf2;
  static int mildBlue = 0xff198df8;
  static int mildDarkBlue = 0xff0f4ffb;

  static double intensity = 0.7;
  static double depth = 8.0;
  static double surfaceIntensity = 0.1;
  static int baseColor = 0xFFEEEEEE;

  static int textBaseColor = 0xFF616161; // Colors.grey[700]
}

class NeumorphicCaveSettings {
  static double caveIntensity = 0.7;
  static double caveDepth = -3;
  static int caveColor = 0xFFF5F5F5;
}

class NeumorphicButtonSettings {
  static double buttonIntensity = 0.8;
  static double buttonDepth = 10;
  static double buttonSurfaceIntensity = 0.0;
}

class BuildButton {
  Widget buildButton({
    String text,
    int color,
    VoidCallback onClick,
    double bottom = 27.0,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: bottom),
      padding: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          border: NeumorphicBorder(
            isEnabled: false,
            width: 0.1,
          ),
          shape: NeumorphicShape.convex,
          depth: NeumorphicButtonSettings.buttonDepth,
          intensity: NeumorphicButtonSettings.buttonIntensity,
          surfaceIntensity: NeumorphicButtonSettings.buttonSurfaceIntensity,
          color: Color(NeumorphicCardSettings.baseColor)),
      child: Center(
        child: NeumorphicText(
          text,
          style: NeumorphicStyle(
            depth: 2, //customize depth here
            color: Color(color), //customize color here
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight, //customize size here
            // AND others usual text style properties (fontFamily, fontWeight, ...)
          ),
        ),
      ),
      onPressed: onClick,
    );
  }
}
