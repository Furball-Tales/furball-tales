import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import '../../sign_in.dart';
import '../../get_allPetsData.dart';


void main() {

  runApp(MaterialApp(
    home: WalkHistory(),
  ));
}

List walks = [];

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
  
class WalkHistory extends StatefulWidget {
  const WalkHistory({Key key}): super(key:key);

  @override
  _WalkHistoryState createState() => _WalkHistoryState();
  
  }

  class _WalkHistoryState extends State<WalkHistory> {

  var stream;
  var date;
  var formattedDate;
  String currentDate;
  List poopQuality = ["dry like a desert", "rainbow colored", "sweet like candy", "like a waterfall", "Same as Mine! Poop Buddies!"];
  List walk = [Icons.sentiment_very_dissatisfied, Icons.sentiment_dissatisfied, Icons.sentiment_neutral, Icons.sentiment_satisfied, Icons.sentiment_very_satisfied];

  void initState() {
    super.initState();
    makePetsList();
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedItem = _dropdownMenuItems[0].value;
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


  @override
  Widget build(BuildContext context) {

    String selectedKey = allPetsData[0]['key'];
    final databaseReference =FirebaseDatabase.instance.reference().child('$id').child('pets').child('$selectedKey').child('walk');
    
    for (var i = 0; i < allPetsData.length; i++) {
      if (i + 1 == _selectedItem.value) {
        selectedKey = allPetsData[i]['key'];
      }
    }

    return Scaffold(
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

      body: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child('$id').child('pets').child('$selectedKey').child('walk').onValue,
          builder: (context, snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              List item = [];
              data.forEach(
                  (index, value) => item.add({"key": index, ...value}));
                  return ListView.builder(
                
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                  
                  currentDate = item[index]["Date"];
                  date = DateFormat('yyyy-MM-dd').parse(currentDate);
                  formattedDate = DateFormat('yyyy-MM-dd').format(date);

                    return Card(
                      child: ListTile(
                          title: Text('$formattedDate'),
                          subtitle: Text(item[index]["Dog Enjoyment"]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          onTap: () {
                            currentDate = item[index]["Date"];
                            String poop = item[index]["Poop Quality"];
                            int poopIndex = int.parse(poop);
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
                                              print(key);
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('$id')
                                                  .child('pets')
                                                  .child('$selectedKey')
                                                  .child('walk')
                                                  .child('$key')
                                                  .remove();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                      title: Text('$formattedDate'),
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
                                                child: Text("Enjoyment:",
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
                                                      item[index]["Dog Enjoyment"],
                                                      style: TextStyle(
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
                                                    child: Text("Number of Poops:",
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
                                                              ["Number of Poops"],
                                                          style: TextStyle(
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
                                                    child: Text("Poop Quality:",
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
                                                      child: Text('${poopQuality[poopIndex]}',
                                                          style: TextStyle(
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
                                                    child: Text("Walk Duration (min):",
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
                                                          item[index]["Walk"],
                                                          style: TextStyle(
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
                                                              20, 0, 0, 0),
                                                      child: Text(
                                                          item[index]["Comments"],
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18.0,
                                                          )),
                                                    ),
                                                  ),
                                                ]),
                                            ]
                                        ),
                                      ));
                                });
                          }),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}