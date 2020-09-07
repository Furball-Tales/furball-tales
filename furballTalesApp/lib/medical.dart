
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'sign_in.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


void main()=> runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    accentColor: Colors.green
  ),
));

class Medical extends StatefulWidget {
  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  final databaseReference = FirebaseDatabase.instance.reference().child('$id').child('vetinfos');

  List history = List();
  String dateValue = "Not set";
  String hospital = "";
  String veterinarian = "";
  String vaccinations = "";
  String medications = "";
  String weight = "";
  String notes = "";
  
  addHistory(){
   //Map
   Map<String, String> history = {
     "Date": dateValue,
     "Hospital": hospital,
     "Veterinarian": veterinarian,
     "Vaccinations": vaccinations,
     "Medications": medications,
     "Weight": weight,
     "Notes": notes
   };

   databaseReference.push().set(history).whenComplete(() {
     print("Medical history created");
   });
  }
  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical History")
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context, 
          builder:(BuildContext context) {
            return AlertDialog (
              actions:<Widget>[
              FlatButton(
                onPressed:(){
                  addHistory();
                  Navigator.of(context).pop();
                },
                child: Text("Add History")
              )
            ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
              title: Text("Add History"),
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -50.0,
                    top: -50.0,
                    child: InkResponse(
                      onTap: () {
                      Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                
                Form(
                  child: SingleChildScrollView(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(16.0), 
                            child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              onPressed: () {
                                  DatePicker.showDatePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight:210.0,
                                  ),
                                    showTitleActions: true, 
                                    minTime: DateTime(2000, 1, 1),
                                    maxTime: DateTime(2050,12,31), onConfirm: (date) {
                                      dateValue = '${date.year} - ${date.month} - ${date.day}';
                                      print('this is the dateValue $dateValue');
                                      setState((){});
                                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                                  },
                                  child: Container(
                                    alignment: Alignment.center, 
                                    height: 50.0, 
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.date_range,
                                                    size: 13.0,
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    "$dateValue",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.0),
                                                    ),
                                                ]
                                              )
                                            )
                                          ]
                                        ),
                                        Text(
                                          " x ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0),
                                          ),
                                      ],
                                    ),
                                  ),
                                  color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child:TextFormField(
                            onChanged: (String hospitalValue) {
                              hospital = hospitalValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Hospital'
                            )
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (String veterinarianValue) {
                              veterinarian = veterinarianValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Vet Name'
                            )
                          )
                        ),
                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (String vaccinationValue) {
                              vaccinations = vaccinationValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Vaccinations'
                            )
                          )
                        ),
                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (String medicationValue) {
                              medications = medicationValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Medication'
                            )
                          )
                        ),
                          Padding(
                          padding:EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (String weightValue) {
                              weight = weightValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Weight'
                            )
                          )
                        ),
                        Padding(
                          padding:EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged:(String notesValue){
                              notes = notesValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Notes'
                            )
                          )
                        ),
                      ],
                    ),
                  )
                )],
            )
            );
          }
        );
      },
  // @override
  // Widget build(BuildContext context) {
  //   // getData();
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Medical History")
  //     ),
  //     floatingActionButton: FloatingActionButton(onPressed: () {
  //       showDialog(
  //         context: context, 
  //         builder:(BuildContext context) {
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8)),
  //             title: Text("Add History"),
  //             content: TextField(
  //               onChanged:(String value){
  //                 input = value;
  //               },
  //             ),
  //             actions:<Widget>[
  //               FlatButton(
  //                 onPressed:(){
  //                   addHistory();
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Text("Add"))
  //             ],
  //           );
  //       });
  //     },

      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ), 
      body: StreamBuilder(stream: databaseReference.onValue, builder:(context, snap) {
        if(snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
        
        Map data = snap.data.snapshot.value;
        List item = [];
          data.forEach((index, data) => item.add({"key": index, ...data}));
          print('this is item $item');
          return ListView.builder (
            itemCount: item.length, 
            itemBuilder: (context, index) {
              return ListTile(
                    title: Text(item[index]["Date"]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState((){
                          String key = item[index]['key'];
                          print('this is the key $key');
                          databaseReference.child('$key').remove();
                        }); 
                      }),
                  );
            });
              } else{
              return Center(child:Text("Yuta is gone"));
            }
      }),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:rapido/rapido.dart';

// class Medical extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MedicalField(),
//     );
//   }
// }

// class MedicalField extends StatefulWidget {
//   @override
//   _MedicalFieldState createState() => _MedicalFieldState();
// }

// class _MedicalFieldState extends State<MedicalField> {
//   final DocumentList documentList = DocumentList(
//     "task list",
//     labels: {
//       "Date": "date",
//       "Title": "title",
//       "Weight": "pri count",
//       "Vet": "vet",
//       "Hospital": "hospital",
//       "Vaccination": "vaccination",
//       "Other notes": "other",
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return DocumentListScaffold(
//       documentList,
//       title: "Medical Histories",
//     );
//   }
// }



