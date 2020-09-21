import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class WalkChart extends StatefulWidget {
  String heading;
  String petName;
  List<dynamic> allWalkChartData;

  // WalkChart(heading, petName, allWalkChartData) {
  //   this.heading = heading;
  //   this.petName = petName;
  //   this.allWalkChartData = allWalkChartData;
  // }

  @override
  _WalkChartState createState() => _WalkChartState();
}

class _WalkChartState extends State<WalkChart> {
  final List<DataPoint<DateTime>> data = [];
  DateTime fromDate;
  DateTime toDate;
  String heading;
  String petName;
  List<dynamic> allWalkChartData;

  @override
  void initState() {
    super.initState();
    fromDate = DateTime(2020, 08, 1);
    toDate = DateTime(2020, 09, 30);
    heading = widget.heading;
    petName = widget.petName;
    allWalkChartData = widget.allWalkChartData;
    DateTime parseDateString(String str) {
      final splitted = str.split("-").map(int.parse).toList();
      return DateTime(splitted[0], splitted[1], splitted[2]);
    }

    for (int i = 0; i < allWalkChartData.length; i++) {
      if (allWalkChartData[i]['data']['petName'] != petName) continue;

      print(allWalkChartData[i]['data']['weight']);
      // headingはすべて小文字にする
      // headingに応じて、取ってくるvalueの位置を変更する
      // またｈは、もう諦めて別ファイルを作ってしまう
      // 値が0のときの挙動
      // 最新までずっと同じ描画にしておく

      final headingData =
          Map<String, dynamic>.from(allWalkChartData[i]['data']['weight']);

      // if (heading == 'weight') var indicator = 'Weight';
      // if (heading == 'food') var indicator = 'BowlPercent';

      for (var value in headingData.values) {
        data.add(
          DataPoint<DateTime>(
            value: double.parse(value['Weight']),
            xAxis: parseDateString(value['Date']),
          ),
        );
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
    allWalkChartData = widget.allWalkChartData;
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
                  label: "Kg",
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
