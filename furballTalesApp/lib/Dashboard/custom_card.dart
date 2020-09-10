import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

class CustomCard extends StatefulWidget {
  String heroTag;
  String photo;

  CustomCard(String heroTag, String photo) {
    this.heroTag = heroTag;
    this.photo = photo;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCardState(heroTag, photo);
  }
}

class CustomCardState extends State<CustomCard> {
  String heroTag;
  String photo;
  var _hasPadding = false;

  CustomCardState(String heroTag, String photo) {
    this.heroTag = heroTag;
    this.photo = photo;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: heroTag,
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
                pageBuilder: (_, __, ___) => DetailPage(heroTag, photo),
              ));
        },
        onTapCancel: () {
          setState(() {
            _hasPadding = false;
          });
        },
        child: Material(
          color: Colors.transparent,
          child: Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                surfaceIntensity: surfaceIntensity,
                depth: depth,
                intensity: intensity,
                lightSource: LightSource.topLeft,
                color: Color(baseColor)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(photo, fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}
