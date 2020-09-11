import 'package:flutter/material.dart';
import './memo/memo.dart';
import './grid_dashboard.dart';
import '../app_bar.dart';
import '../sign_in.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar("Furball Tales", false),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(child: GridDashboard()),
          Container(height: 55, child: MemoList())
        ],
      ),
    );
  }
}
