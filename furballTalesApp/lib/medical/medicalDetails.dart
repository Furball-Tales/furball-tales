import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../sign_in.dart';
import '../frontend_settings.dart';
import '../get_allPetsData.dart';


var baseColor = NeumorphicCardSettings.baseColor;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.green),
    ));


class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class Medical extends StatefulWidget {
  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  DateTime medicalDate;

  final databaseReference =
      FirebaseDatabase.instance.reference().child('$id').child('pets');


  @override
  void initState() {
    super.initState();
    medicalDate = DateTime.now();
    makePetsList();
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedItem = _dropdownMenuItems[0].value;
    dateValue = '${medicalDate.year}-${medicalDate.month}-${medicalDate.day}';
  }

  List<ListItem> petNames = List();
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  makePetsList() {
    for (var i = 0; i < allPetsData.length; i++) {
      ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
      petNames.add(newListItem);
    }
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

  List history = List();
  String dateValue;
  String hospital = "";
  String veterinarian = "";
  String vaccinations = "";
  String medications = "";
  String weight = "";
  String notes = "";
  String key = "";
  String updateDateValue;
  String updateHospital = "";
  String updateVeterinarian = "";
  String updateVaccinations = "";
  String updateMedications = "";
  String updateWeight = "";
  String updateNotes = "";
  // String petName = allPetsData[0]['data']['petName'];
  String selectedKey = allPetsData[0]['key'];

  addHistory() {
    //Map
    Map<String, String> history = {
      "Date": '$dateValue',
      "Hospital": '$hospital',
      "Veterinarian": '$veterinarian',
      "Vaccinations": '$vaccinations',
      "Medications": '$medications',
      "Weight": '$weight',
      "Notes": '$notes'
    };
    for (var i = 0; i < allPetsData.length; i++) {
      if (i + 1 == _selectedItem.value) {
        selectedKey = allPetsData[i]['key'];
      }
    }
    databaseReference
        .child('$selectedKey')
        .child('vetinfos')
        .push()
        .set(history)
        .whenComplete(() {
      print("Medical history created");
    });
  }

  addWeight() {
    Map<String, String> weightInfo = {
      "Date": '$dateValue',
      "Weight": '$weight'
    };
    for (var i = 0; i < allPetsData.length; i++) {
      if (i + 1 == _selectedItem.value) {
        selectedKey = allPetsData[i]['key'];
      }
    }
    databaseReference
        .child('$selectedKey')
        .child('weight')
        .push()
        .set(weightInfo)
        .whenComplete(() {
      print("weight history created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(baseColor),
      appBar: AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Please select your Furball    ", style:TextStyle(color: Colors.blue, fontSize:16.0)  ),
        DropdownButton(
          value: _selectedItem,
          items: _dropdownMenuItems,
          underline: SizedBox(height: 0,),
          //underline: SizedBox(),
          onChanged:(value){
            setState((){
            _selectedItem = value;
            for (var i = 0; i < allPetsData.length; i++) {
              if (i + 1 == _selectedItem.value) {
                selectedKey = allPetsData[i]['key'];
                  }
              }
            });
          }
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
                                addHistory();
                                addWeight();
                                Navigator.of(context).pop();
                                dateValue =
                                    '${currentdate.year}-${currentdate.month}-${currentdate.day}';
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: DropdownButton<ListItem>(
                                        value: _selectedItem,
                                        items: _dropdownMenuItems,
                                        style: TextStyle(color: Colors.grey),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedItem = value;
                                            for (var i = 0; i < allPetsData.length; i++) {
                                              if (i + 1 == _selectedItem.value) {
                                                selectedKey = allPetsData[i]['key'];
                                              }
                                            }
                                            print(selectedKey);
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
                                        onChanged: (String hospitalValue) {
                                          hospital = hospitalValue;
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Hospital')),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          onChanged:
                                              (String veterinarianValue) {
                                            veterinarian = veterinarianValue;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Vet Name'))),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          onChanged: (String vaccinationValue) {
                                            vaccinations = vaccinationValue;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Vaccinations'))),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          onChanged: (String medicationValue) {
                                            medications = medicationValue;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Medication'))),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          onChanged: (String weightValue) {
                                            weight = weightValue;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Weight'))),
                                  Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: TextFormField(
                                          onChanged: (String notesValue) {
                                            notes = notesValue;
                                          },
                                          decoration: InputDecoration(
                                              labelText: 'Notes'))),
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
          tooltip: 'New History',
        ),
      ),
      body: StreamBuilder(
          stream: databaseReference.child('$selectedKey').child('vetinfos').onValue,
          builder: (context, snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              // print(snap.data.snapshot.value);
              List item = [];
              data.forEach(
                  (index, value) => item.add({"key": index, ...value}));
              // print('this is item $item');
              return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: Text(item[index]["Date"]),
                          subtitle: Text(item[index]["Notes"]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
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
                                              String key = item[index]['key'];
                                              databaseReference
                                                  .child('$selectedKey')
                                                  .child('vetinfos')
                                                  .child('$key')
                                                  .remove();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        FlatButton(
                                          child: Icon(Icons.update),
                                          onPressed: () {
                                            key = item[index]['key'];
                                            updateDateValue =
                                                item[index]["Date"];
                                            updateHospital =
                                                item[index]["Hospital"];
                                            updateVeterinarian =
                                                item[index]["Veterinarian"];
                                            updateVaccinations =
                                                item[index]["Vaccinations"];
                                            updateMedications =
                                                item[index]["Medications"];
                                            updateWeight =
                                                item[index]["Weight"];
                                            updateNotes = item[index]["Notes"];
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                DateTime updatedate =
                                                    DateTime.now();
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return AlertDialog(
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(context)
                                                                  .pop();
                                                              databaseReference
                                                                  .child('$selectedKey')
                                                                  .child('vetinfos')
                                                                  .child('$key')
                                                                  .update({
                                                                "Key": '$key',
                                                                "Date":
                                                                    "$updateDateValue",
                                                                "Hospital":
                                                                    "$updateHospital",
                                                                "Veterinarian":
                                                                    "$updateVeterinarian",
                                                                "Vaccinations":
                                                                    "$updateVaccinations",
                                                                "Medications":
                                                                    "$updateMedications",
                                                                "Weight":
                                                                    "$updateWeight",
                                                                "Notes":
                                                                    "$updateNotes",
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text(
                                                                "Update History"))
                                                      ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      title: Text(
                                                          "Update History"),
                                                      content: Stack(
                                                        overflow:
                                                            Overflow.visible,
                                                        children: <Widget>[
                                                          Form(
                                                              child:
                                                                  SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child:
                                                                      RaisedButton(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0)),
                                                                    elevation:
                                                                        4.0,
                                                                    onPressed:
                                                                        () async {
                                                                      DateTime picked = await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate:
                                                                              updatedate,
                                                                          firstDate: DateTime(updatedate.year -
                                                                              5),
                                                                          lastDate:
                                                                              DateTime(updatedate.year + 5));
                                                                      if (picked !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          updatedate =
                                                                              picked;
                                                                          updateDateValue =
                                                                              '${updatedate.year}-${updatedate.month}-${updatedate.day}';
                                                                        });
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: <
                                                                            Widget>[
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
                                                                                      "$updateDateValue",
                                                                                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15.0),
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
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: TextFormField(
                                                                      initialValue: updateHospital,
                                                                      onChanged: (String hospitalValue) {
                                                                        updateHospital =
                                                                            hospitalValue;
                                                                      },
                                                                      decoration: InputDecoration(labelText: 'Hospital')),
                                                                ),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: TextFormField(
                                                                        initialValue: updateVeterinarian,
                                                                        onChanged: (String veterinarianValue) {
                                                                          updateVeterinarian =
                                                                              veterinarianValue;
                                                                        },
                                                                        decoration: InputDecoration(labelText: 'Vet Name'))),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: TextFormField(
                                                                        initialValue: updateVaccinations,
                                                                        onChanged: (String vaccinationValue) {
                                                                          updateVaccinations =
                                                                              vaccinationValue;
                                                                        },
                                                                        decoration: InputDecoration(labelText: 'Vaccinations'))),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: TextFormField(
                                                                        initialValue: updateMedications,
                                                                        onChanged: (String medicationValue) {
                                                                          updateMedications =
                                                                              medicationValue;
                                                                        },
                                                                        decoration: InputDecoration(labelText: 'Medication'))),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: TextFormField(
                                                                        initialValue: updateWeight,
                                                                        onChanged: (String weightValue) {
                                                                          updateWeight =
                                                                              weightValue;
                                                                        },
                                                                        decoration: InputDecoration(labelText: 'Weight'))),
                                                                Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child: TextFormField(
                                                                        initialValue: updateNotes,
                                                                        onChanged: (String notesValue) {
                                                                          updateNotes =
                                                                              notesValue;
                                                                        },
                                                                        decoration: InputDecoration(labelText: 'Notes'))),
                                                              ],
                                                            ),
                                                          ))
                                                        ],
                                                      ));
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                      title: Text(item[index]["Date"]),
                                      titleTextStyle: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                      titlePadding:
                                          EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      content: IntrinsicHeight(
                                        child: Column(
                                          children: <Widget>[
                                            Row(children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    20, 0, 0, 0),
                                                child: Text("Hospital:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 18.0,
                                                    )),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      20, 0, 0, 0),
                                                  child: Text(
                                                      item[index]["Hospital"],
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 18.0,
                                                      )),
                                                ),
                                              ),
                                            ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                    child: Text("Vet Name:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 18.0,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      child: Text(
                                                          item[index]
                                                              ["Veterinarian"],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 18.0,
                                                          )),
                                                    ),
                                                  ),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                    child: Text("Vaccine:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 18.0,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      child: Text(
                                                          item[index]
                                                              ["Vaccinations"],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 18.0,
                                                          )),
                                                    ),
                                                  ),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                    child: Text("Weight:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 18.0,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      child: Text(
                                                          item[index]["Weight"],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 18.0,
                                                          )),
                                                    ),
                                                  ),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 10),
                                                    child: Text("Notes:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 18.0,
                                                        )),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 10),
                                                      child: Text(
                                                          item[index]["Notes"],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 18.0,
                                                          )),
                                                    ),
                                                  )
                                                ])
                                          ],
                                        ),
                                      ));
                                });
                          }),
                    );
                  });
            } else {
              return Center(child: Text('Add Medical History'));
            }
          }),
    );
  }
}
