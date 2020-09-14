import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';
// import 'chart_dammy_data.dart';

class Chart extends StatefulWidget {
  String petName;
  dynamic allChartData;

  Chart(petName, allChartData) {
    this.petName = petName;
    this.allChartData = allChartData;
    // print(allChartData);
    print(petName);
  }

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  DateTime fromDate;
  DateTime toDate;
  dynamic allChartData;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2019, 09, 1);
    toDate = DateTime(2019, 09, 30);
    this.allChartData = allChartData;
    print(allChartData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // dynamic allChartData;
    final date1 = toDate.subtract(Duration(days: 2));
    final date2 = toDate.subtract(Duration(days: 3));

    // for (var i = 0; i < allChartData.length; i++)
    return Scaffold(
      appBar: GradientAppBar(
        'title',
        // '${allChartData[0]['data']['weight'][0]['value']}',
        // allChartData[i]['petName']',
        'back',
      ),
      // IconButton(
      //     icon: Icon(Icons.today),
      //     onPressed: () {
      //       setState(() {
      //         fromDate = DateTime(2019, 07, 20);
      //       });
      //     }),
      // IconButton(
      //     icon: Icon(Icons.history),
      //     onPressed: () {
      //       setState(() {
      //         fromDate = DateTime(2019, 08, 1);
      //       });
      //     }),
      body: Center(
        child: Container(
          color: Colors.red,
          //height: MediaQuery.of(context).size.height / 2,
          //width: MediaQuery.of(context).size.width,
          child: BezierChart(
            fromDate: fromDate,
            bezierChartScale: BezierChartScale.WEEKLY,
            toDate: toDate,
            onIndicatorVisible: (val) {
              // print(allChartData);
              print("Indicator Visible :$val");
            },
            onDateTimeSelected: (datetime) {
              print("selected datetime: $datetime");
            },
            selectedDate: toDate,
            //this is optional
            footerDateTimeBuilder:
                (DateTime value, BezierChartScale scaleType) {
              final newFormat = intl.DateFormat('dd/MMM');
              return newFormat.format(value);
            },
            bubbleLabelDateTimeBuilder:
                (DateTime value, BezierChartScale scaleType) {
              final newFormat = intl.DateFormat('EEE d');
              return "${newFormat.format(value)}\n";
            },
            series: [
              BezierLine(
                label: "Duty",
                onMissingValue: (dateTime) {
                  return 3120.5;
                },
                data: [
                  DataPoint<DateTime>(
                      value: 2340.5, xAxis: DateTime(2019, 9, 24)),
                  DataPoint<DateTime>(
                      value: 2340.5, xAxis: DateTime(2019, 9, 25)),
                  DataPoint<DateTime>(
                      value: 2115.21, xAxis: DateTime(2019, 9, 26)),
                  DataPoint<DateTime>(
                      value: 3120.5, xAxis: DateTime(2019, 9, 27)),
                  DataPoint<DateTime>(
                      value: 3235.9, xAxis: DateTime(2019, 9, 30)),
                ],
              ),
            ],
            config: BezierChartConfig(
              updatePositionOnTap: true,
              bubbleIndicatorValueFormat:
                  intl.NumberFormat("###,##0.00", "en_US"),
              verticalIndicatorStrokeWidth: 1.0,
              verticalIndicatorColor: Colors.white30,
              showVerticalIndicator: true,
              verticalIndicatorFixedPosition: false,
              backgroundColor: Colors.transparent,
              footerHeight: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
