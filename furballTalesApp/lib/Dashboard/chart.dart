import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';

var allChartData = [
  {
    'key': '2020-09-11=17:25:57:351',
    'petName': 'Jimmy',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
  {
    'key': '2020-09-11=17:25:57:352',
    'petName': 'Anny',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
  {
    'key': '2020-09-11=17:25:57:353',
    'petName': 'Angy',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
  {
    'key': '2020-09-11=17:25:57:354',
    'petName': 'Jiro',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
  {
    'key': '2020-09-11=17:25:57:355',
    'petName': 'Suga Yoshihide',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
  {
    'key': '2020-09-11=17:25:57:356',
    'petName': 'Nozomi Sasaki',
    'data': {
      'food': [
        {
          'dateTime': '2020, 8, 21',
          'value': 300,
        },
        {
          'dateTime': '2020, 8, 22',
          'value': 300,
        },
      ],
      'walk': [
        {
          'dateTime': '2020, 8, 23',
          'value': 30,
        },
        {
          'dateTime': '2020, 8, 24',
          'value': 90,
        },
      ],
      'weight': [
        {
          'dateTime': '2020, 8, 25',
          'value': 1450,
        },
        {
          'dateTime': '2020, 8, 26',
          'value': 1890,
        },
      ],
    }
  },
];

class Chart extends StatefulWidget {
  // List<Map<String, Object>> allChartData;

  // Chart(List<Map<String, Object>> allChartData) {
  //   this.allChartData = allChartData;
  // }

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  DateTime fromDate;
  DateTime toDate;
  // List<Map<String, Object>> allChartData;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2019, 09, 1);
    toDate = DateTime(2019, 09, 30);
    // this.allChartData = allChartData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, Object>> allChartData;
    print(allChartData.length);
    final date1 = toDate.subtract(Duration(days: 2));
    final date2 = toDate.subtract(Duration(days: 3));

    for (var i = 0; i < allChartData.length; i++)
      return Scaffold(
        appBar: GradientAppBar(
          allChartData[i]['petName'],
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
                        value: 3235.9, xAxis: DateTime(2019, 9, 24)),
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
