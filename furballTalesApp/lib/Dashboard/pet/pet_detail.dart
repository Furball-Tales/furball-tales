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
}

Future deletePetInfo(petId) async {
  databaseReference.child(petId).remove();
}

Future updatePetInfo(petId, birthday, petName, sex) async {
  databaseReference
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 40.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 16.0,
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
                                  height: 120,
                                  width: 240,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                        left: 20,
                                        right: 20,
                                        bottom: 5,
                                      ),
                                      child: StreamBuilder(
                                        stream: databaseReference.onValue,
                                        builder: (context, snap) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 2),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 3,
                                                    bottom: 20,
                                                  ),
                                                  child: Text(
                                                    name,
                                                    style: TextStyle(
                                                      color:
                                                          Color(textBaseColor),
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                right: 8),
                                                        child: Text(
                                                          sex,
                                                          style: TextStyle(
                                                            color: Color(
                                                                textBaseColor),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 4),
                                                        child: Text(
                                                          age + ' yrs',
                                                          style: TextStyle(
                                                            color: Color(
                                                                textBaseColor),
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                            color: Color(0xff00b8d4),
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
