import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../../get_allPetsData.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../sign_in.dart';
class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}
class WalkChart extends StatefulWidget {
  String heading;
  String petName;
  @override
  _WalkChartState createState() => _WalkChartState();
}
DateTime now = DateTime.now();
DateTime today = DateTime(now.year, now.month, now.day);
class _WalkChartState extends State<WalkChart> {
  List<DataPoint<DateTime>> walkData = [];
  DateTime fromDate;
  DateTime toDate;
  List test = [];
  List walks = [];
  String selectedKey = allPetsData[0]['key'];
  List<ListItem> petNames = List();
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;
  makePetsList() {
    for (var i = 0; i < allPetsData.length; i++) {
      ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
      petNames.add(newListItem);
    }
  }
  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
  DateTime parseDateString(String str) {
    final splitted = str.split("-").map(int.parse).toList();
    return DateTime(splitted[0], splitted[1], splitted[2]);
  }
  @override
  void initState() {
    super.initState();
    makePetsList();
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedItem = _dropdownMenuItems[0].value;
    // set the chart duration
    fromDate = DateTime(2020, 09, 1);
    toDate = today;
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Please select your Furball    ",
                style: TextStyle(color: Colors.blue, fontSize: 16.0)),
            DropdownButton(
                value: _selectedItem,
                items: _dropdownMenuItems,
                underline: SizedBox(
                  height: 0,
                ),
                //underline: SizedBox(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    for (var i = 0; i < allPetsData.length; i++) {
                      if (i + 1 == _selectedItem.value) {
                        selectedKey = allPetsData[i]['key'];
                        print('this is selected key $selectedKey');
                      }
                    }
                  });
                }),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child('$id')
              .child('pets')
              .child('$selectedKey')
              .child('walk')
              .onValue,
          builder: (context, snap) {
            walks = [];
            walkData = [];
            if (snap.hasData &&
                !snap.hasError &&
                snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              data.forEach(
                  (index, value) => walks.add({"key": index, ...value}));
              for (int i = 0; i < walks.length; i++) {
                if (walks[i]['petKey'] != selectedKey) continue;
                // handling the edge case where no such category is provided
                var dataOfWalk = double.parse(walks[i]['Walk']);
                var dataOfData = DateTime.parse(walks[i]['Date']);
                walkData.add(
                  DataPoint<DateTime>(
                    value: dataOfWalk,
                    xAxis: dataOfData,
                  ),
                );
              }
              return Container(
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
                        // print('this is value $value');
                        return newFormat.format(value);
                      },
                      bubbleLabelDateTimeBuilder:
                          (DateTime value, BezierChartScale scaleType) {
                        final newFormat = intl.DateFormat('MMM d EEE');
                        return "${newFormat.format(value)}\n";
                      },
                      series: [
                        BezierLine(
                          label: "min",
                          data: walkData,
                          onMissingValue: (DateTime dateTime) {
                            double lastValue = 0;
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
              );
            } else {
              return Center(child: Text("Retrieve Walk Statistics"));
            }
          }),
    );
  }
}