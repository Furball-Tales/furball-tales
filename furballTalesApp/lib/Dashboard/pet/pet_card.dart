import 'package:flutter/material.dart';
import 'pet_detail.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../frontend_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../grid_dashboard.dart';
import '../../get_allPetsData.dart';

var accentBlue = NeumorphicCardSettings.accentBlue;
var accentPink = NeumorphicCardSettings.accentPink;
var accentYellow = NeumorphicCardSettings.accentYellow;
var intensity = NeumorphicCardSettings.intensity;
var depth = NeumorphicCardSettings.depth;
var surfaceIntensity = NeumorphicCardSettings.surfaceIntensity;
var baseColor = NeumorphicCardSettings.baseColor;

var caveIntensity = NeumorphicCaveSettings.caveIntensity;
var caveDepth = NeumorphicCaveSettings.caveDepth;
var caveColor = NeumorphicCaveSettings.caveColor;

var textBaseColor = NeumorphicCardSettings.textBaseColor;

class PetCard extends StatefulWidget {
  String heroTag;
  String birthday;
  String name;
  String photo;
  String sex;

  PetCard(
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
  State<StatefulWidget> createState() {
    return PetCardState(
      heroTag,
      birthday,
      name,
      photo,
      sex,
    );
  }
}

class PetCardState extends State<PetCard> {
  String heroTag;
  String birthday;
  String name;
  String photo;
  String sex;

  var _hasPadding = false;

  File _image;
  final picker = ImagePicker();

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    var uploadUrl = await uploadImage(_image, this.heroTag);
    updateUrl(uploadUrl, this.heroTag);
    // await readUrl();
    this.photo = uploadUrl;
    readAllPetsData();

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String calculateAge(String stringBirthday) {
    DateTime dataBirthday = DateTime.parse(stringBirthday);
    Duration differenceDays = DateTime.now().difference(dataBirthday);
    var _age = (differenceDays.inDays / 365).floor().toString();
    return _age;
  }

  PetCardState(
    String heroTag,
    String birthday,
    String name,
    String photo,
    String sex,
  ) {
    this.heroTag = heroTag;
    this.birthday = calculateAge(birthday);
    this.name = name;
    this.photo = photo;
    this.sex = sex;
  }

  @override
  Widget build(BuildContext context) {
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
                pageBuilder: (_, __, ___) => PetDetail(
                  heroTag,
                  birthday,
                  name,
                  photo,
                  sex,
                ),
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
                depth: 5,
                intensity: intensity,
                lightSource: LightSource.topLeft,
                color: Color(baseColor)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: StreamBuilder(
                      stream: databaseReference.onValue,
                      builder: (context, snap) {
                        return Container(
                          width: 70.0,
                          height: 70.0,
                          margin: EdgeInsets.only(
                            top: 3,
                            bottom: 1,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(photo),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
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
                              height: 80,
                              width: 110,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 12,
                                    bottom: 12,
                                  ),
                                  child: StreamBuilder(
                                      stream: databaseReference.onValue,
                                      builder: (context, snap) {
                                        return Container(
                                          padding:
                                              EdgeInsets.only(top: 12, left: 2),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                name,
                                                style: TextStyle(
                                                  color: Color(textBaseColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                sex,
                                                style: TextStyle(
                                                  color: Color(textBaseColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                birthday + ' yrs',
                                                style: TextStyle(
                                                  color: Color(textBaseColor),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              // Text('Weight: $_weight'),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
