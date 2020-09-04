
import 'package:flutter/material.dart';
import 'package:rapido/rapido.dart';

class Medical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MedicalField(),
    );
  }
}

class MedicalField extends StatefulWidget {
  @override
  _MedicalFieldState createState() => _MedicalFieldState();
}

class _MedicalFieldState extends State<MedicalField> {
  final DocumentList documentList = DocumentList(
    "task list",
    labels: {
      "Date": "date",
      "Title": "title",
      "Weight": "pri count",
      "Vet": "vet",
      "Hospital": "hospital",
      "Vaccination": "vaccination",
      "Other notes": "other",
    },
  );

  @override
  Widget build(BuildContext context) {
    return DocumentListScaffold(
      documentList,
      title: "Medical Histories",
    );
  }
}
