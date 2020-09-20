import 'package:flutter/material.dart';
import '../../main.dart';
import '../../frontend_settings.dart';
import '../../app_bar.dart';
import '../../get_allPetsData.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../each_jump_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../sign_in.dart';

var baseColor = NeumorphicCardSettings.baseColor;

var mildBlueGreen = NeumorphicCardSettings.mildBlueGreen;
var mildBlue = NeumorphicCardSettings.mildBlue;
var mildDarkBlue = NeumorphicCardSettings.mildDarkBlue;

class FoodDetail extends StatefulWidget {
  IconData icon;
  String heading;
  int color;
  List<dynamic> allChartData;

  FoodDetail(
    IconData icon,
    String heading,
    int color,
    List<dynamic> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
    this.allChartData = allChartData;
  }

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class _FoodDetailState extends State<FoodDetail> {
  DateTime foodDate;
  String dateValue = "Not set";
  String brandName = "";
  double bowlPercent = 80;

  ListItem chosenPet;
  List<ListItem> petNames = List();
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedPet;

  final databaseReference =
      FirebaseDatabase.instance.reference().child('$id').child('pets');

  makePetsList() {
    for (var i = 0; i < allPetsData.length; i++) {
      ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
      petNames.add(newListItem);
    }
  }

  @override
  void initState() {
    super.initState();
    foodDate = DateTime.now();
    makePetsList();
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedPet = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  addFood() {
    //Map
    Map<String, String> foodObj = {
      "Date": '$dateValue',
      "Brand": '$brandName',
      "BowlPercent": '$bowlPercent',
    };
    String selectedKey;
    for (var i = 0; i < allPetsData.length; i++) {
      if (i + 1 == _selectedPet.value) {
        selectedKey = allPetsData[i]['key'];
      }
    }

    databaseReference
        .child(selectedKey)
        .child("food")
        .push()
        .set(foodObj)
        .whenComplete(() {
      print("Food history created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        "Food History",
        'back',
      ),
      backgroundColor:
          Color(baseColor), //Make background of overall Widget transparent
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: widget.heading,
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    color: Color(baseColor),
                    child: Text(''),
                  ),
                )),
            for (var i = 0; i < allPetsData.length; i++)
              Container(
                // giving some mergin
                margin: EdgeInsets.only(
                  top: 15,
                  right: 20,
                  left: 20,
                  bottom: 10,
                ),
                child: EachJumpCard(
                  widget.icon,
                  widget.heading,
                  allPetsData[i]['data']['petName'],
                  widget.color,
                  widget.color,
                  intensity,
                  depth,
                  surfaceIntensity,
                  baseColor,
                  widget.allChartData,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: NeumorphicTheme(
        child: NeumorphicFloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  DateTime currentdate = DateTime.now();

                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                        actions: <Widget>[
                          NeumorphicTheme(
                            child: NeumorphicButton(
                              child: const Text('Add'),
                              onPressed: () {
                                addFood();
                                Navigator.of(context).pop();
                                dateValue = "Not Set";
                              },
                              style: NeumorphicStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: Text("Add History"),
                        content: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Form(
                                child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: DropdownButton<ListItem>(
                                        value: _selectedPet,
                                        items: _dropdownMenuItems,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedPet = value;
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      elevation: 4.0,
                                      onPressed: () async {
                                        DateTime picked = await showDatePicker(
                                            context: context,
                                            initialDate: currentdate,
                                            firstDate:
                                                DateTime(currentdate.year - 5),
                                            lastDate:
                                                DateTime(currentdate.year + 5));
                                        if (picked != null) {
                                          setState(() {
                                            currentdate = picked;
                                            dateValue =
                                                '${currentdate.year}-${currentdate.month}-${currentdate.day}';
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
                                                      new Text(
                                                        "${currentdate.year} - ${currentdate.month} - ${currentdate.day}",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                        onChanged: (String brandNameValue) {
                                          brandName = brandNameValue;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Brand Name')),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Column(children: <Widget>[
                                        Text("Percentage of Bowl eaten %"),
                                        Slider(
                                          value: bowlPercent,
                                          min: 0,
                                          max: 100,
                                          divisions: 10,
                                          label: bowlPercent.round().toString(),
                                          onChanged: (double value) {
                                            setState(() {
                                              bowlPercent = value;
                                            });
                                          },
                                        ),
                                      ])),
                                ],
                              ),
                            ))
                          ],
                        ));
                  });
                });
          },
          child: Container(
            color: Color(baseColor),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
          tooltip: 'New Event',
        ),
      ),
    );
  }

  Widget imageContents(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        height: 277,
        color: Colors.white,
        child: Container(
            child: Stack(
          children: <Widget>[
            Center(
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 30,
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
