import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:filter_list/filter_list.dart';
import '../../sign_in.dart';
import '../../get_allPetsData.dart';

void main() {

  runApp(MaterialApp(
    home: WalkHistory(),
  ));
}



class WalkHistory extends StatefulWidget {
  const WalkHistory({Key key}): super(key:key);

  @override
  _WalkHistoryState createState() => _WalkHistoryState();
  
  }

  class _WalkHistoryState extends State<WalkHistory> {

  var date;
  var formattedDate;
  String currentDate;

  @override
  Widget build(BuildContext context) {

    String selectedKey = allPetsData[0]['key'];
    final databaseReference =FirebaseDatabase.instance.reference().child('$id').child('pets').child('$selectedKey').child('walk');

    List<String> countList = [];
    List<String> selectedCountList = [];
      for (var i = 0; i < allPetsData.length; i++) {
        countList.add(allPetsData[i]['key']);
      }

    void _openFilterList() async{
      // print(selectedCountList[index]);
      var list = await FilterList.showFilterList(
        context,
        allTextList: countList,
        height: 450,
        borderRadius: 20,
        headlineText: "Select Count",
        searchFieldHintText: "Search Here",
        selectedTextList: selectedCountList,
        );
                      
      if (list != null) {
        setState(() {
        selectedCountList = List.from(list);
        });
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed:_openFilterList,
      ),

      body: StreamBuilder(
          stream: databaseReference.onValue,
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
                                              databaseReference
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
                                                child: Text("Enjoyment Rating:",
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
                                                      child: Text(
                                                          item[index]
                                                              ["Poop Quality"],
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
                                                            fontWeight:
                                                                FontWeight.bold,
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