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

final databaseReference =
    FirebaseDatabase.instance.reference().child('$id').child('pets');

class InitialRegistration extends StatefulWidget {
  @override
  _InitialRegistrationState createState() => _InitialRegistrationState();
}

// var _url;
bool existData;

Future createPetdata(birthday, petName, petProfilePicUrl, sex) async {
  databaseReference.push().set({
    "birthday": birthday,
    "petName": petName,
    "petProfilePicUrl": petProfilePicUrl,
    "sex": sex, // ♂,♀
  });
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

Future<String> uploadImage(var imageFile) async {
  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child('$id')
      .child("profileImage")
      .child("profileImage.jpg");
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
  var _dateText = 'Please select a Pet Birthday.';
  var _url;

  // File _image;
  final picker = ImagePicker();

  Future selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // _image = File(pickedFile.path);
    File imageData = File(pickedFile.path);
    _url = await uploadImage(imageData);
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
      appBar: GradientAppBar("Furball Tales", false),
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Initial Registration of Pet's Information"),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      controller: _petNameController,
                      decoration: InputDecoration(labelText: 'Pet Name'),
                      textInputAction: TextInputAction.next,
                      autovalidate: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please input a Pet Name.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      controller: _petSexController,
                      decoration: InputDecoration(labelText: 'Pet Sex'),
                      textInputAction: TextInputAction.next,
                      autovalidate: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please input a Pet Sex.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text('Pet Birthday: '),
                  ),
                  IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () => {_selectDate(context), _text = ""}),
                  Text(
                    _dateText,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text('Pet Image: '),
                  ),
                  GestureDetector(
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
                              width: 115.0,
                              height: 115.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347"),
                                  ))))
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () => {
                          if ((_dateText != 'Please select a Pet Birthday.') &&
                              (_petNameController.text != "") &&
                              (_url != null) &&
                              (_petSexController.text != ""))
                            {
                              createPetdata(_dateText, _petNameController.text,
                                  _url, _petSexController.text),
                              setState(
                                () {
                                  funcIndex = "Homepage";
                                },
                              ),
                            }
                          else
                            {
                              setState(
                                () {
                                  _text = "Please fill out all items.";
                                },
                              ),
                            }
                        }),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(_text, style: TextStyle(color: Colors.red)),
              )
            ],
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
