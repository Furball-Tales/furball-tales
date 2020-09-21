// import 'package:intl/intl.dart' as intl;
// import 'package:bezier_chart/bezier_chart.dart';
// import 'package:flutter/material.dart';
// import 'walkHistory.dart';
// import '../../get_allPetsData.dart';

// class WalkChart extends StatefulWidget {
//   String heading;
//   String petName;

//   // List<dynamic> allChartData;

//   // WalkChart(heading, petName, allChartData) {
//   //   this.heading = heading;
//   //   this.petName = petName;
//   //   this.allChartData = allChartData;
//   // }

//   @override
//   _WalkChartState createState() => _WalkChartState();
// }

// class _WalkChartState extends State<WalkChart> {
//   int index; 
//   String selectedKey = allPetsData[2]['key'];
//   final List<DataPoint<DateTime>> walkData = [];
//   DateTime fromDate;
//   DateTime toDate;
//   // String heading;
//   // String lowerHeading;
//   // String petName;
//   List names = [];
//   String petName = allPetsData[0]['data']['petName'];
//   // List<dynamic> walks;

// List<ListItem> petNames = List();
//   List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
//   ListItem _selectedItem;

//   makePetsList() {
//     for (var i = 0; i < allPetsData.length; i++) {
//       ListItem newListItem = ListItem(i + 1, allPetsData[i]['data']['petName']);
//       petNames.add(newListItem);
//     }
//   }

//   List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
//     List<DropdownMenuItem<ListItem>> items = List();
//     for (ListItem listItem in listItems) {
//       items.add(
//         DropdownMenuItem(
//           child: Text(listItem.name),
//           value: listItem,
//         ),
//       );
//     }
//     return items;
//   }

//   @override
//   void initState() {
//     super.initState();
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year, now.month, now.day);
//     makePetsList();
//     _dropdownMenuItems = buildDropDownMenuItems(petNames);
//     _selectedItem = _dropdownMenuItems[0].value;
//     print('this is selectedKey $selectedKey');
//     print('this is walks $walks');


//     // set the chart duration
//     fromDate = DateTime(2020, 09, 1);
//     toDate = today;

//     // heading = widget.heading; 
//     // lowerHeading =
//     //     '${heading[0].toLowerCase()}${heading.substring(1)}';
//     // petName = widget.petName;
//     // allChartData = widget.allChartData;

//     DateTime parseDateString(String str) {
//       final splitted = str.split("-").map(int.parse).toList();
//       return DateTime(splitted[0], splitted[1], splitted[2]);
//     }

//     for (int i = 0; i < walks.length; i++) {
//       // if (walks[index]['Walk'] != null) continue;

//       // handling the edge case where no such category is provided
//       if ((walks[i]['Walk']) == null) {
//         Map<String, dynamic>dummyData = {
//           'key': {
//             'Date': today,
//             'Walk': 0.0,
//             // heading: 0.0,
//           },
//         };
//         walkData.add(
//           DataPoint<DateTime>(
//             value: dummyData['key']['Walk'],
//             xAxis: dummyData['key']['Date'],
//           ),
//         );
//         // handling normal case
//       } else {
//         final headingData =
//             Map<String, dynamic>.from(
//               (walks[i]['Walk'])
//               );

//         for (var value in headingData.values) {
//           if (value['Walk'] == '' || value['Date'] == 'Not set') continue;
//           walkData.add(
//             DataPoint<DateTime>(
//               value: double.parse(value['Walk']),
//               xAxis: parseDateString(value['Date']),
//             ),
//           );
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // heading = widget.heading;
//     // petName = widget.petName;
//     // allChartData = widget.allChartData;
//     // final date1 = toDate.subtract(Duration(days: 2));
//     // final date2 = toDate.subtract(Duration(days: 3));

//     return Scaffold(
//       appBar: AppBar(
//     backgroundColor: Colors.white,
//     automaticallyImplyLeading: false,
//     title: Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text("Please select your Furball    ", style:TextStyle(color: Colors.blue, fontSize:16.0)  ),
//           DropdownButton(
//           value: _selectedItem,
//           items: _dropdownMenuItems,
//           underline: SizedBox(height: 0,),
//           //underline: SizedBox(),
//           onChanged:(value){
//             setState((){
//             _selectedItem = value;
//                 for (var i = 0; i < allPetsData.length; i++) {
//                   if (i + 1 == _selectedItem.value) {
//                     selectedKey = allPetsData[i]['key'];
//                   }
//                 }
//             });
//           }
//         ),
//       ],
//       ),
//     ),
//       extendBodyBehindAppBar: true,
//       // IconButton(
//       //     icon: Icon(Icons.today),
//       //     onPressed: () {
//       //       setState(() {
//       //         fromDate = DateTime(2019, 07, 20);
//       //       });
//       //     }),
//       // IconButton(
//       //     icon: Icon(Icons.history),
//       //     onPressed: () {
//       //       setState(() {
//       //         fromDate = DateTime(2019, 08, 1);
//       //       });
//       //     }),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: FractionalOffset.topLeft,
//             end: FractionalOffset.bottomRight,
//             colors: [
//               const Color(0xffe4a972).withOpacity(0.6),
//               const Color(0xff9941d8).withOpacity(0.6),
//             ],
//             stops: const [
//               0.0,
//               1.0,
//             ],
//           ),
//         ),
//         child: Center(
//           child: Container(
//             color: Colors.transparent,
//             //height: MediaQuery.of(context).size.height / 2,
//             //width: MediaQuery.of(context).size.width,
//             child: BezierChart(
//               fromDate: fromDate,
//               bezierChartScale: BezierChartScale.WEEKLY,
//               toDate: toDate,
//               onIndicatorVisible: (val) {
//                 print("Indicator Visible :$val");
//               },
//               onDateTimeSelected: (datetime) {
//                 print("selected datetime: $datetime");
//               },
//               selectedDate: toDate,
//               //this is optional
//               footerDateTimeBuilder:
//                   (DateTime value, BezierChartScale scaleType) {
//                 final newFormat = intl.DateFormat('dd/MMM');
//                 return newFormat.format(value);
//               },
//               bubbleLabelDateTimeBuilder:
//                   (DateTime value, BezierChartScale scaleType) {
//                 final newFormat = intl.DateFormat('MMM d EEE');
//                 return "${newFormat.format(value)}\n";
//               },
//               series: [
//                 BezierLine(
//                   label: "min",
//                   data: walkData,
//                   onMissingValue: (DateTime dateTime) {
//                     double lastValue = 0;

//                     for (final dataPoint in walkData) {
//                       if (dataPoint.xAxis.isAfter(dateTime)) {
//                         lastValue = dataPoint.value;
//                         break;
//                       }
//                     }
//                     return lastValue;
//                   },
//                 ),
//               ],
//               config: BezierChartConfig(
//                 updatePositionOnTap: true,
//                 bubbleIndicatorValueFormat:
//                     intl.NumberFormat("###,##0.00", "en_US"),
//                 verticalIndicatorStrokeWidth: 1.0,
//                 verticalIndicatorColor: Colors.white,
//                 showVerticalIndicator: true,
//                 verticalIndicatorFixedPosition: false,
//                 backgroundColor: Colors.transparent,
//                 footerHeight: 40.0,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:intl/intl.dart' as intl;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import '../../get_allPetsData.dart';
import 'walkHistory.dart';



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

class _WalkChartState extends State<WalkChart> {
  final List<DataPoint<DateTime>> walkData = [];
  DateTime fromDate;
  DateTime toDate;
  String heading = "Walk";
  String lowerHeading = "walk";
  String petName = "Bella";
  String selectedKey = allPetsData[0]['key'];
  // List<dynamic> allChartData;

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



  @override
  void initState() {
    super.initState();
    print('this is walks $walks');
    print('this is selectedKey $selectedKey');
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    _dropdownMenuItems = buildDropDownMenuItems(petNames);
    _selectedItem = _dropdownMenuItems[0].value;
  

    // set the chart duration
    fromDate = DateTime(2020, 09, 1);
    toDate = today;



    // heading = widget.heading; // 'Weight'
    // lowerHeading =
    //     '${heading[0].toLowerCase()}${heading.substring(1)}'; // 'weight'
    // petName = widget.petName;
    // allChartData = widget.allChartData;
    DateTime parseDateString(String str) {
      final splitted = str.split("-").map(int.parse).toList();
      return DateTime(splitted[0], splitted[1], splitted[2]);
    }

    for (int i = 0; i < walks.length; i++) {
      if (walks[i]['petKey'] != selectedKey) continue;

      // handling the edge case where no such category is provided
      if ((walks[i]['Walk']) == null) {
        Map<String, dynamic> dummyData = {
          'key': {
            'Date': today,
            'Walk': 0.0,
          },
        };
        walkData.add(
          DataPoint<DateTime>(
            value: dummyData['key']['Walk'],
            xAxis: dummyData['key']['Date'],
          ),
        );
        // handling normal case
      } else {
        final headingData =
            Map<String, dynamic>.from((walks[i]['Walk']));

        for (var value in headingData.values) {
          if (value['Walk'] == '' || value['Date'] == 'Not set') continue;
          walkData.add(
            DataPoint<DateTime>(
              value: double.parse(value['Walk']),
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

    return Scaffold(
      appBar: AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Please select your Furball    ", style:TextStyle(color: Colors.blue, fontSize:16.0)  ),
        DropdownButton(
          value: _selectedItem,
          items: _dropdownMenuItems,
          underline: SizedBox(height: 0,),
          //underline: SizedBox(),
          onChanged:(value){
            setState((){
            _selectedItem = value;
                for (var i = 0; i < allPetsData.length; i++) {
                  if (i + 1 == _selectedItem.value) {
                    selectedKey = allPetsData[i]['key'];
                    print(selectedKey);
                  }
                }
            });
          }
        ),
      ],
      ),
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
                  label: "min",
                  data: walkData,
                  onMissingValue: (DateTime dateTime) {
                    double lastValue = 0;

                    for (final dataPoint in walkData) {
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

