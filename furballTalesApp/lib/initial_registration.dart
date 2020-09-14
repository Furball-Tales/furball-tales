import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'homepage.dart';
import 'package:intl/intl.dart';
import './app_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './dashboard/grid_dashboard.dart';
import 'frontend_settings.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'get_allPetsData.dart';

var textBaseColor = NeumorphicCardSettings.textBaseColor;
var baseColor = NeumorphicCardSettings.baseColor;

var buttonIntensity = NeumorphicButtonSettings.buttonIntensity;
var buttonDepth = NeumorphicButtonSettings.buttonDepth;
var buttonSurfaceIntensity = NeumorphicButtonSettings.buttonSurfaceIntensity;

_buildButton({String text, int color, VoidCallback onClick}) =>
    BuildButton().buildButton;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Neumorphic',
      home: InitialRegistration(),
    );
  }
}

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

class InitialRegistration extends StatefulWidget {
  @override
  _InitialRegistrationState createState() => _InitialRegistrationState();
}

// var _url;
// var allPetsData = [];
bool existData;

// Future readAllPetsData() async {
//   await databaseReference.orderByKey().once().then((DataSnapshot snapshot) {
//     snapshot.value.forEach((key, data) => {
//           allPetsData.add({"key": key, "data": data})
//         });
//     allPetsData.sort((a, b) => b['key'].compareTo(a['key']));
//   });
//   print("Out allPetsData: $allPetsData");
//   print("Out allPetsData[0]: ${allPetsData[0]}");
//   print("allPetsData[0]['key']: ${allPetsData[0]['key']}");
// }

Future createPetdata(birthday, petName, petProfilePicUrl, sex) async {
  String nowDateText =
      (DateFormat("yyyy-MM-dd=HH:mm:ss:SSS")).format(DateTime.now());
  print("nowDateText: $nowDateText");
  databaseReference.child(nowDateText).set({
    "birthday": birthday,
    "petName": petName,
    "petProfilePicUrl": petProfilePicUrl,
    "sex": sex, // ♂,♀
  });
}

Future updatePetImage(var imageFile) async {
  await readAllPetsData();
  var petId = allPetsData[0]['key'];
  var uploadUrl = await uploadImage(imageFile, petId);

  updateUrl(uploadUrl, petId);
}

Future checkPetData() async {
  var readData;
  await databaseReference.once().then((DataSnapshot snapshot) {
    readData = snapshot.value;
  });
  if (readData != null) {
    existData = true;
  } else {
    existData = false;
  }
}

Future<String> uploadTemporaryImage(var imageFile) async {
  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child('$id')
      .child("profileTemporaryImage")
      .child("profileTemporaryImage.jpg");
  StorageUploadTask uploadTask =
      ref.putFile(imageFile, StorageMetadata(contentType: 'image/jpeg'));
  final snapshot = await uploadTask.onComplete;
  var downUrl;
  if (snapshot.error == null) {
    downUrl = await snapshot.ref.getDownloadURL();
  } else {
    print(snapshot.error);
    downUrl = null;
  }
  String url = downUrl.toString();

  return url;
}

class _InitialRegistrationState extends State<InitialRegistration> {
  var _petNameController = TextEditingController();
  var _petSexController = TextEditingController();
  var _text = '';
  var _dateText = '';
  var _url;
  File imageData;

  // File _image;
  final picker = ImagePicker();

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // _image = File(pickedFile.path);
    imageData = File(pickedFile.path);
    _url = await uploadTemporaryImage(imageData);
    // updateUrl(uploadUrl);
    // await readUrl();

    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        _dateText = (DateFormat("yyyy-MM-dd")).format(selected);
      });
    }
  }

  Widget initialRegistrationScreen() {
    return Scaffold(
      appBar: GradientAppBar(
        "Pet Registeration",
        'back',
      ),
      backgroundColor: Color(baseColor),
      body: Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(12),
          ),
          color: Color(baseColor),
          intensity: 0.8,
          depth: 7,
        ),
        child: NeumorphicTheme(
          child: Container(
            padding: EdgeInsets.only(
              right: 32.0,
              left: 32.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20.0),
                    child: Text(
                      "Please register your pet information.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(accentBlue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: _TextField(
                      label: "Pet Name",
                      hint: "Bella",
                      controller: _petNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: _TextField(
                      label: "Sex",
                      hint: "Female",
                      controller: _petSexController,
                    ),
                  ),
                  // TextFormField(
                  //   controller: _petNameController,
                  //   decoration: InputDecoration(
                  //       hintText: 'Pet Name',
                  //       hintStyle: TextStyle(
                  //         fontSize: 14,
                  //       )),
                  //   textInputAction: TextInputAction.next,
                  //   autofocus: true,
                  //   autovalidate: true,
                  //   validator: (String value) {
                  //     if (value.isEmpty) {
                  //       return 'Required';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // Row(
                  //   children: <Widget>[
                  //     Expanded(
                  //       flex: 7,
                  //       child: TextFormField(
                  //         controller: _petSexController,
                  //         decoration: InputDecoration(labelText: 'Pet Sex'),
                  //         textInputAction: TextInputAction.next,
                  //         autovalidate: true,
                  //         validator: (String value) {
                  //           if (value.isEmpty) {
                  //             return 'Please input a Pet Sex.';
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 35,
                      bottom: 32.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Birthday:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(textBaseColor),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _dateText,
                              style: TextStyle(fontSize: 14),
                            ),
                            IconButton(
                              icon: NeumorphicIcon(
                                Icons.date_range,
                                size: 45,
                                style: NeumorphicStyle(
                                  // shape: NeumorphicShape.convex,
                                  // surfaceIntensity: 1.0,
                                  intensity: 1.0,
                                  depth: 2,
                                  color: Color(baseColor),
                                ),
                              ),
                              color: Color(textBaseColor),
                              onPressed: () =>
                                  {_selectDate(context), _text = ""},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 18,
                      bottom: 35,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Pet Image: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(textBaseColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              selectImage();
                              _text = "";
                            },
                            child: (_url != null)
                                ? Container(
                                    width: 115.0,
                                    height: 115.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(_url),
                                        )))
                                : Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347"),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 40,
                          left: 40,
                        ),
                        child: _buildButton()(
                          text: "Complete!",
                          color: accentBlue,
                          onClick: () => {
                            if ((_dateText !=
                                    'Please select a Pet Birthday.') &&
                                (_petNameController.text != "") &&
                                (_url != null) &&
                                (_petSexController.text != ""))
                              {
                                createPetdata(
                                    _dateText,
                                    _petNameController.text,
                                    _url,
                                    _petSexController.text),
                                updatePetImage(imageData).whenComplete(
                                  () => setState(
                                    () {
                                      funcIndex = "Homepage";
                                    },
                                  ),
                                ),
                              }
                            else
                              {
                                setState(
                                  () {
                                    _text = "Please fill in all fields.";
                                  },
                                ),
                              }
                          },
                          bottom: 14.0,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          _text,
                          style: TextStyle(
                            color: Colors.red[600],
                          ),
                        ),
                      )
                    ],
                  )

                      // Container(
                      //   padding: EdgeInsets.all(16.0),
                      //   child: RaisedButton(
                      //       child: Text('Submit'),
                      //       onPressed: () => {
                      // if ((_dateText !=
                      //         'Please select a Pet Birthday.') &&
                      //     (_petNameController.text != "") &&
                      //     (_url != null) &&
                      //     (_petSexController.text != ""))
                      //   {
                      //     createPetdata(
                      //         _dateText,
                      //         _petNameController.text,
                      //         _url,
                      //         _petSexController.text),
                      //     updatePetImage(imageData),
                      //     setState(
                      //       () {
                      //         funcIndex = "Homepage";
                      //       },
                      //     ),
                      //   }
                      // else
                      //   {
                      //     setState(
                      //       () {
                      //         _text = "Please fill out all items.";
                      //       },
                      //     ),
                      //   }
                      //           }),
                      // ),

                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var func;
  var funcIndex = "initialRegistrationScreen";

  @override
  Widget build(BuildContext context) {
    if (funcIndex == "initialRegistrationScreen") {
      func = initialRegistrationScreen();
    } else {
      func = Homepage();
    }
    return func;
  }
}

class _TextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  // final ValueChanged<String> onChanged;

  _TextField({
    @required this.label,
    this.hint,
    this.controller,
  });

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  // TextEditingController _controller;

  // @override
  // void initState() {
  //   _controller = TextEditingController(text: widget.hint);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(textBaseColor),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
            color: Color(baseColor),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextFormField(
            controller: this.widget.controller,
            decoration: InputDecoration.collapsed(
              hintText: this.widget.hint,
              hintStyle: TextStyle(
                fontSize: 12,
              ),
            ),
            textInputAction: TextInputAction.next,
            autovalidate: true,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
