import 'package:flutter/material.dart';
import '../../main.dart';
import '../../frontend_settings.dart';
import '../each_jump_card.dart';
import '../../app_bar.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../sign_in.dart';
import '../../get_allPetsData.dart';

var baseColor = NeumorphicCardSettings.baseColor;

var mildBlueGreen = NeumorphicCardSettings.mildBlueGreen;
var mildBlue = NeumorphicCardSettings.mildBlue;
var mildDarkBlue = NeumorphicCardSettings.mildDarkBlue;

class WeightDetail extends StatefulWidget {
  IconData icon;
  String heading;
  int color;
  List<Map<String, Object>> allChartData;

  WeightDetail(
    IconData icon,
    String heading,
    int color,
    List<Map<String, Object>> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
    this.allChartData = allChartData;
  }

  @override
  _WeightDetail createState() => _WeightDetail();
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class _WeightDetail extends State<WeightDetail> {
  IconData icon;
  String heading;
  int color;
  List<Map<String, Object>> allChartData;

  WeightDetail(
    IconData icon,
    String heading,
    int color,
    List<Map<String, Object>> allChartData,
  ) {
    this.icon = icon;
    this.heading = heading;
    this.color = color;
    this.allChartData = allChartData;
  }

  final databaseReference =
      FirebaseDatabase.instance.reference().child('$id').child('pets');

  DateTime weightDate;
  String dateValue = "Not set";
  String weight = "";

  ListItem chosenPet;
  List<ListItem> petNames = List();
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedPet;

  makePetsList() {
    for (var i = 0; i < allPetsData.length; i++) {
      ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
      petNames.add(newListItem);
    }
  }

  @override
  void initState() {
    super.initState();
    weightDate = DateTime.now();
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

  addWeight() {
    //Map
    Map<String, String> weightObj = {
      "Date": '$dateValue',
      "Weight": '$weight',
    };
    String selectedKey;
    for (var i = 0; i < allPetsData.length; i++) {
      if (i + 1 == _selectedPet.value) {
        selectedKey = allPetsData[i]['key'];
      }
    }

    databaseReference
        .child(selectedKey)
        .child("weight")
        .push()
        .set(weightObj)
        .whenComplete(() {
      print("Weight history created");
    });
  }

  @override
  Widget build(BuildContext context) {
    heading = widget.heading;
    allChartData = widget.allChartData;

    return Scaffold(
      appBar: GradientAppBar(
        "Weight History",
        'back',
      ),
      backgroundColor:
          Color(baseColor), //Make background of overall Widget transparent
      floatingActionButton: NeumorphicTheme(
        child: NeumorphicFloatingActionButton(
          tooltip: 'New Weight',
          child: Container(
            color: Color(baseColor),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
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
                                addWeight();
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
                                        onChanged: (String weightValue) {
                                          weight = weightValue;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Weight (kg)')),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ));
                  });
                });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: heading,
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
                  Icons.line_weight,
                  heading,
                  allPetsData[i]['data']['petName'],
                  mildBlueGreen,
                  mildBlueGreen,
                  intensity,
                  depth,
                  surfaceIntensity,
                  baseColor,
                  allChartData,
                ),
              ),
            // EachJumpCard(
            //   Icons.directions_run,
            //   "Pet Name1",
            //   mildBlueGreen,
            //   mildBlueGreen,
            //   intensity,
            //   depth,
            //   surfaceIntensity,
            //   baseColor,
            //   allChartData,
            // )
          ],
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
              child: Icon(
                icon,
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
