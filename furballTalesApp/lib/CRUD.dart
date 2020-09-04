// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';


// class FirstScreen extends StatelessWidget {

// //getting the id passed to here?
//   final databaseReference = FirebaseDatabase.instance.reference().child('id');


//   @override
//   Widget build(BuildContext context) {
//     getData();

//     //check if it's working
//     print('this is $id');


//     return Scaffold(
//         appBar: AppBar(
//             title: Text('Firebase Connect'),
//             ),
//         body: Center(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[

//                   RaisedButton(
//                       child: Text('Create Record'),
//                       onPressed: () {
//                         createRecord();
//                       },
//                   ),

//                   RaisedButton(
//                       child: Text('View Record'),
//                       onPressed: () {
//                         getData();
//                       },
//                   ),
//                   RaisedButton(
//                       child: Text('Update Record'),
//                       onPressed: () {
//                         updateData();
//                       },
//                   ),
//                   RaisedButton(
//                       child: Text('Delete Record'),
//                       onPressed: () {
//                         deleteData();
//                       },
//                   ),
//                 ],
//             )
//         ), //center
//     );
//   }

//   void createRecord(){
//     databaseReference.child("3").push().set({
//       'title': 'new user - is this working??',
//       'description': 'it is working'
//     });
//     databaseReference.child("2").set({
//       'title': 'Flutter in Action',
//       'description': 'Complete Programming Guide to learn Flutter'
//     });
//   }
//   void getData(){
//     databaseReference.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//     });
//   }

//   void updateData(){
//     databaseReference.child('1').update({
//       'description': 'J2EE complete Reference'
//     });
//   }

//   void deleteData(){
//     databaseReference.child('1').remove();
//   }
// }
