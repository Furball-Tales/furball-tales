import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../app_bar.dart';
import '../frontend_settings.dart';
import 'medicalDetails.dart';

var baseColor = NeumorphicCardSettings.baseColor;

class MedicalDetail extends StatefulWidget {
  @override
  _MedicalDetailState createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        "Medical Details",
        'null',
    ),
    body: Medical(),
    );
  }
}
