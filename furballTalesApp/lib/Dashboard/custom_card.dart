import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
                surfaceIntensity: 0.1,
                depth: 1.5,
                intensity: 0.7,
                lightSource: LightSource.topLeft,
                color: Colors.grey[200]),
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
