import 'package:flutter/material.dart';
// import '../../main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../grid_dashboard.dart';
import '../../frontend_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../get_allPetsData.dart';
import 'package:intl/intl.dart';

var baseColor = NeumorphicCardSettings.baseColor;
var textBaseColor = NeumorphicCardSettings.textBaseColor;
var brightLavender = NeumorphicCardSettings.brightLavender;
var accentGold = NeumorphicCardSettings.accentGold;

class PetDetail extends StatefulWidget {
  String heroTag;
  String birthday;
  String age;
  String name;
  String photo;
  String sex;

  PetDetail(
    String heroTag,
    String birthday,
    String age,
    String name,
    String photo,
    String sex,
  ) {
    this.heroTag = heroTag;
    this.birthday = birthday;
    this.age = age;
    this.name = name;
    this.photo = photo;
    this.sex = sex;
  }

  @override
  State<StatefulWidget> createState() {
    return PetDetailState(
      heroTag,
      birthday,
      age,
      name,
      photo,
      sex,
    );
  }
}

Future deleteUrl(petId, petProfilePicUrl) async {
  databaseReference.child(petId).update({'petProfilePicUrl': petProfilePicUrl});
  databaseReferencePetinfo
      .child(petId)
      .update({'petProfilePicUrl': petProfilePicUrl});
}

Future deletePetInfo(petId) async {
  databaseReference.child(petId).remove();
  databaseReferencePetinfo.child(petId).remove();
}

Future updatePetInfo(petId, birthday, petName, sex) async {
  databaseReference
      .child(petId)
      .update({'birthday': birthday, 'petName': petName, 'sex': sex});
  databaseReferencePetinfo
      .child(petId)
      .update({'birthday': birthday, 'petName': petName, 'sex': sex});
}

class PetDetailState extends State<PetDetail> {
  String heroTag;
  String birthday;
  String age;
  String name;
  String photo;
  String sex;

  PetDetailState(
    String heroTag,
    String birthday,
    String age,
    String name,
    String photo,
    String sex,
  ) {
    this.heroTag = heroTag;
    this.birthday = birthday;
    this.age = age;
    this.name = name;
    this.photo = photo;
    this.sex = sex;
  }

  File _image;
  final picker = ImagePicker();
  String updateBirthday = "";
  String updateName = "";
  String updateSex = "";

  String calculateAge(String stringBirthday) {
    DateTime dataBirthday = DateTime.parse(stringBirthday);
    Duration differenceDays = DateTime.now().difference(dataBirthday);
    var _age = (differenceDays.inDays / 365).floor().toString();
    return _age;
  }

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    var uploadUrl = await uploadImage(_image, this.heroTag);
    updateUrl(uploadUrl, this.heroTag);
    // await readUrl();
    this.photo = uploadUrl;
    readAllPetsDataPetinfo();
    readAllPetsData();

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void showUpdateInfoDialog() async {
    updateBirthday = this.birthday;
    updateName = this.name;
    updateSex = this.sex;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime updatedate = DateTime.parse(updateBirthday);
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      print(
                          "Update Info: $updateBirthday, $updateName, $updateSex");
                      updatePetInfo(
                          this.heroTag, updateBirthday, updateName, updateSex);
                      readAllPetsDataPetinfo();
                      readAllPetsData();
                      setState(() {
                        this.name = updateName;
                        this.birthday = updateBirthday;
                        this.age = calculateAge(updateBirthday);
                        this.sex = updateSex;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Update"))
              ],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text("Update Pet Information"),
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Form(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 4.0,
                            onPressed: () async {
                              DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: updatedate,
                                  firstDate: DateTime(updatedate.year - 5),
                                  lastDate: DateTime(updatedate.year + 5));
                              if (picked != null) {
                                setState(() {
                                  updatedate = picked;
                                  updateBirthday = (DateFormat("yyyy-MM-dd"))
                                      .format(updatedate);
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              size: 15.0,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              "$updateBirthday",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Change",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TextFormField(
                              initialValue: updateName,
                              onChanged: (String nameValue) {
                                updateName = nameValue;
                              },
                              decoration: InputDecoration(labelText: 'Name')),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: TextFormField(
                                initialValue: updateSex,
                                onChanged: (String sexValue) {
                                  updateSex = sexValue;
                                },
                                decoration: InputDecoration(labelText: 'Sex'))),
                      ],
                    ),
                  ))
                ],
              ));
        });
      },
    );
  }

  final Shader linearGradientPurple = LinearGradient(
    colors: <Color>[Color(brightLavender), Color(pastelMagenta)],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final Shader linearGradientBlue = LinearGradient(
    colors: <Color>[Color(0xff00e6ff), Color(0xffccffb3)],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  CalculateDaysUntilNextBirthday(stringBirthday) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime dataBirthday = DateTime.parse(stringBirthday);

    DateTime thisBirthday =
        DateTime(now.year, dataBirthday.month, dataBirthday.day);
    DateTime nextBirthday =
        DateTime(now.year + 1, dataBirthday.month, dataBirthday.day);

    if (thisBirthday.difference(today).inDays > 1) {
      return thisBirthday.difference(today).inDays;
    } else {
      return nextBirthday.difference(today).inDays;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, //Make background of overall Widget transparent
      body: Hero(
        tag: heroTag,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            color: Color(baseColor),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InkResponse(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      print(
                                          "Delete Image this.heroTag: ${this.heroTag}");
                                      this.photo =
                                          "https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347";

                                      deleteUrl(this.heroTag, this.photo);
                                      readAllPetsDataPetinfo();
                                      readAllPetsData();
                                      this.photo = this.photo;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                                FlatButton(
                                  child: Icon(Icons.update),
                                  onPressed: () {
                                    print(
                                        "Update Image this.heroTag: ${this.heroTag}");
                                    selectImage();
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                              title: Text("Edit pet photo?"),
                            );
                          });
                    },
                    child: Container(
                      height: 300,
                      child: imageContents(context),
                    ),
                  ),
                ),
                Expanded(
                  child: InkResponse(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {
                                    print(
                                        "Delete Info this.heroTag: ${this.heroTag}");
                                    deletePetInfo(this.heroTag);
                                    readAllPetsDataPetinfo();
                                    readAllPetsData();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Icon(Icons.update),
                                  onPressed: () {
                                    print(
                                        "Update Info this.heroTag: ${this.heroTag}");
                                    showUpdateInfoDialog();
                                  },
                                )
                              ],
                              title: Text("Edit pet information?"),
                            );
                          });
                    },
                    child: Container(
                      height: 500,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          bottom: 16.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.convex,
                                    depth: -6,
                                    intensity: 0.8,
                                    surfaceIntensity: 0.1,
                                    lightSource: LightSource.topLeft,
                                    color: Color(baseColor)),
                                child: Container(
                                  color: Colors.transparent,
                                  height: 300,
                                  width: 300,
                                  child: NeumorphicTheme(
                                    child: SingleChildScrollView(
                                      child: Center(
                                        child: StreamBuilder(
                                          stream: databaseReference.onValue,
                                          builder: (context, snap) {
                                            return Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SingleChildScrollView(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 35,
                                                        bottom: 10,
                                                      ),
                                                      child: NeumorphicText(
                                                        name,
                                                        style: NeumorphicStyle(
                                                          depth: 3,
                                                          color:
                                                              Colors.grey[600],
                                                          intensity: 1,
                                                        ),
                                                        textStyle:
                                                            NeumorphicTextStyle(
                                                                fontSize: 50,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 15,
                                                      bottom: 30,
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            sex,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              foreground: Paint()
                                                                ..shader =
                                                                    linearGradientPurple,
                                                            ),
                                                          ),
                                                          Text(
                                                            age + ' yrs',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              foreground: Paint()
                                                                ..shader =
                                                                    linearGradientPurple,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.cake,
                                                        color:
                                                            Color(accentGold),
                                                        size: 23.3,
                                                      ),
                                                      Text(
                                                        CalculateDaysUntilNextBirthday(
                                                                birthday)
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 40,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(accentGold),
                                                        ),
                                                      ),
                                                      Text(
                                                        ' days until next birthday!',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(accentGold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Image Widget
  Widget imageContents(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        height: 277,
        color: Colors.white,
        child: Container(
            child: Stack(
          children: <Widget>[
            Center(
              child: Image.network(
                photo,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: statusBarHeight),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Container(
                          child: RaisedButton(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            color: Colors.grey[400],
                            shape: CircleBorder(),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MyApp();
                                }),
                              );
                            },
                          ),
                        )
                      ]),
                )
              ],
            )
          ],
        )));
  }
}
