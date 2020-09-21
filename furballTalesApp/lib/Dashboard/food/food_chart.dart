import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class FoodChart extends StatefulWidget {
  String heading;
  String petName;
  List<dynamic> allChartData;

  FoodChart(heading, petName, allChartData) {
    this.heading = heading;
    this.petName = petName;
    this.allChartData = allChartData;
  }

  @override
  _FoodChartState createState() => _FoodChartState();
}

class _FoodChartState extends State<FoodChart> {
  final List<DataPoint<DateTime>> data = [];
  DateTime fromDate;
  DateTime toDate;
  String heading;
  String lowerHeading;
  String petName;
  List<dynamic> allChartData;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // set the chart duration
    fromDate = DateTime(2020, 09, 1);
    toDate = today;

    heading = widget.heading; // 'Food'
    lowerHeading =
        '${heading[0].toLowerCase()}${heading.substring(1)}'; // 'food'
    petName = widget.petName;
    allChartData = widget.allChartData;
    DateTime parseDateString(String str) {
      final splitted = str.split("-").map(int.parse).toList();
      return DateTime(splitted[0], splitted[1], splitted[2]);
    }

    for (int i = 0; i < allChartData.length; i++) {
      if (allChartData[i]['data']['petName'] != petName) continue;

      // handling the edge case where no such category is provided
      if ((allChartData[i]['data'][lowerHeading]) == null) {
        Map<String, dynamic> dammyData = {
          'key': {
            'Date': today,
            'BowlPercent': 0.0,
          },
        };
        data.add(
          DataPoint<DateTime>(
            value: dammyData['key']['BowlPercent'],
            xAxis: dammyData['key']['Date'],
          ),
        );
        // handling normal case
      } else {
        final headingData =
            Map<String, dynamic>.from((allChartData[i]['data'][lowerHeading]));

        for (var value in headingData.values) {
          if (value['BowlPercent'] == '' || value['Date'] == 'Not set')
            continue;
          data.add(
            DataPoint<DateTime>(
              value: double.parse(value['BowlPercent']),
              xAxis: parseDateString(value['Date']),
            ),
          );
        }
      }
    }
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
    // final date1 = toDate.subtract(Duration(days: 2));
    // final date2 = toDate.subtract(Duration(days: 3));

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
                  label: "%",
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
