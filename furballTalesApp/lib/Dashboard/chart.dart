import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../app_bar.dart';

class Chart extends StatefulWidget {
  String heading;
  String petName;
  dynamic allChartData;

  Chart(heading, petName, allChartData) {
    this.heading = heading;
    this.petName = petName;
    this.allChartData = allChartData;
  }

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  DateTime fromDate;
  DateTime toDate;
  String heading;
  String petName;
  dynamic allChartData;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2019, 09, 1);
    toDate = DateTime(2019, 09, 30);
    heading = widget.heading;
    petName = widget.petName;
    allChartData = widget.allChartData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    heading = widget.heading;
    petName = widget.petName;
    allChartData = widget.allChartData;
    final date1 = toDate.subtract(Duration(days: 2));
    final date2 = toDate.subtract(Duration(days: 3));

    dynamic data = [
      DataPoint<DateTime>(value: 2340.5, xAxis: DateTime(2019, 9, 24)),
      DataPoint<DateTime>(value: 2340.5, xAxis: DateTime(2019, 9, 25)),
      DataPoint<DateTime>(value: 2115.21, xAxis: DateTime(2019, 9, 26)),
      DataPoint<DateTime>(value: 3120.5, xAxis: DateTime(2019, 9, 27)),
      DataPoint<DateTime>(value: 3235.9, xAxis: DateTime(2019, 9, 30)),
    ];

    for (var i = 0; i < allChartData.length; i++) {
      if (allChartData[i]['petName'] == petName) {
        // dynamic data = allChartData[i];

        return Scaffold(
          appBar: AppBar(
            title: Text(
              heading + ' History of ' + petName,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: true,
          ),
          extendBodyBehindAppBar: true,
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
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [
                  const Color(0xffe4a972).withOpacity(0.6),
                  const Color(0xff9941d8).withOpacity(0.6),
                ],
                stops: const [
                  0.0,
                  1.0,
                ],
              ),
            ),
            child: Center(
              child: Container(
                color: Colors.transparent,
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
                    final newFormat = intl.DateFormat('MMM d EEE');
                    return "${newFormat.format(value)}\n";
                  },
                  series: [
                    BezierLine(
                      label: "grams",
                      data: data,
                      onMissingValue: (DateTime dateTime) {
                        double lastValue = 0;

                        for (final dataPoint in data) {
                          if (dataPoint.xAxis.isAfter(dateTime)) {
                            lastValue = dataPoint.value;
                            break;
                          }
                        }
                        return lastValue;
                      },
                    ),
                  ],
                  config: BezierChartConfig(
                    updatePositionOnTap: true,
                    bubbleIndicatorValueFormat:
                        intl.NumberFormat("###,##0.00", "en_US"),
                    verticalIndicatorStrokeWidth: 1.0,
                    verticalIndicatorColor: Colors.white,
                    showVerticalIndicator: true,
                    verticalIndicatorFixedPosition: false,
                    backgroundColor: Colors.transparent,
                    footerHeight: 40.0,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
