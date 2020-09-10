import 'package:flutter/material.dart';
import './memo.dart';
import './grid_dashboard.dart';
import '../app_bar.dart';

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
