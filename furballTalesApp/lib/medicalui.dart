import 'package:flutter/material.dart';

class medicalui extends StatefulWidget {
  @override
  _medicaluiState createState() => _medicaluiState();
}

class _medicaluiState extends State<medicalui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionbutton: FloatingActionButton(onPressed:(){},
      child: Icon(TextEditingController(Icons.add, color: Colors.white,),
      ),
      backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(
          "My Appointments",
          style: TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
    );
  }
}