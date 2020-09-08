// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';


// class Medicalui extends StatefulWidget {
//   @override
//   _MedicaluiState createState() => _MedicaluiState();
// }

// class _MedicaluiState extends State<Medicalui> {

// final texteditingcontroller = TextEditingController();
// bool validated = true;
// String errtext = "";
// String todoedited = "";

// final databaseReference = FirebaseDatabase.instance.reference();

//   void createRecord(){
//     databaseReference.child("3").push().set({
//       "description":'$todoedited'
//     });

//   }

//   void showalertdialog(){
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder:(context, setState){
//           return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         title: Text (
//           "Add Task"
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextField(
//               controller:texteditingcontroller,
//               autofocus: true,
//               onChanged: (_val){
//                 todoedited = _val;
//               },
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontFamily: "Raleway"
//               ),
//               decoration: InputDecoration(
//                 errorText: validated ? null : errtext,
//               )
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: 10.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//               RaisedButton(
//                           onPressed: () {
//                             if (texteditingcontroller.text.isEmpty) {
//                               setState(() {
//                                 errtext = "Can't Be Empty";
//                                 validated = false;
//                               });
//                             } else if (texteditingcontroller.text.length >
//                                 512) {
//                               setState(() {
//                                 errtext = "Too may Chanracters";
//                                 validated = false;
//                               });
//                             } else {
//                               createRecord();
//                             }
//                           },
//                           color: Colors.purple,
//                           child: Text("ADD",
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontFamily: "Raleway",
//                               )),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//       });
//       }
//     );
//   }

//   Widget mycard(String task){
//   return Card(
//     elevation: 5.0,
//     margin: EdgeInsets.symmetric(
//       horizontal: 10.0, 
//       vertical: 5.0),
//     child: Container(
//       padding: EdgeInsets.all(5.0),
//       child: ListTile(
//         title: Text(
//           "$task",
//           style: TextStyle(fontSize:18.0,
//           fontFamily: "raleway")
//           ),
//           onLongPress:(){
//             print("Should Get Deleted");
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed:showalertdialog,
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       backgroundColor: Colors.blue,
//       appBar: AppBar(
//         title: Text(
//           "My Appointments",
//           style: TextStyle(
//             fontFamily: "Raleway",
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.black,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             mycard("Record A Video"),
//             mycard("Go to sleep")
//           ],
//         ),
//       ),
//     );
//   }
// }