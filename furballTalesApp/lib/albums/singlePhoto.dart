import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';
import 'package:photo_view/photo_view.dart';

var baseColor = NeumorphicCardSettings.baseColor;

class SinglePhoto extends StatelessWidget {
  String _photoLink;

  SinglePhoto(String photoLink) {
    this._photoLink = photoLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GradientAppBar(
      //   "Full Screen",
      //   'back',
      // ),
      body: Container(
        color: Color(baseColor),
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topLeft,
        child: Center(
          child: PhotoHero(
            photo: this._photoLink,
            width: double.infinity,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: PhotoView(
              imageProvider: NetworkImage(
                photo,
              ),
              backgroundDecoration: BoxDecoration(color: Color(baseColor)),
            ),
          ),
        ),
      ),
    );
  }
}
