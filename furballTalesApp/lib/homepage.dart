import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';
import 'profile/profile.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'medical/medical.dart';
import 'albums/albums.dart';
import 'frontend_settings.dart';
import 'calendar/calendar_main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

var baseColor = NeumorphicCardSettings.baseColor;

void main() => runApp(MyApp());

class IndexController with ChangeNotifier {
  int index = 0;

  void setIndex(int i) {
    this.index = i;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Colors.grey[50],
        lightSource: LightSource.topLeft,
        depth: 5,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Homepage> {
  double get w => MediaQuery.of(context).size.width;
  double get h => MediaQuery.of(context).size.height;

  final List<Widget> _children = [
    Dashboard(),
    Albums(),
    Calendar(),
    Medical(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IndexController>(
      create: (_) => IndexController(),
      child: Scaffold(
        backgroundColor: Color(baseColor),
        body: Consumer<IndexController>(
          builder: (context, controller, child) {
            return _children[controller.index];
          },
        ),
        bottomNavigationBar: FourthNav(w: w),
      ),
    );
  }
}

class FourthNav extends StatefulWidget {
  final double w;

  FourthNav({Key key, this.w}) : super(key: key);
  @override
  FourthNavState createState() => FourthNavState();
}

class FourthNavState extends State<FourthNav> {
  List<Nav4ItemClass> items4 = List<Nav4ItemClass>();
  int pos = 0;

  @override
  void initState() {
    super.initState();

    items4.add(Nav4ItemClass(
      true,
      'assets/svg/home.svg',
      'Dashboard',
      0,
    ));
    items4.add(Nav4ItemClass(
      false,
      'assets/svg/picture-2.svg',
      'Albums',
      1,
    ));
    items4.add(Nav4ItemClass(
      false,
      'assets/svg/calendar-6.svg',
      'Calendar',
      2,
    ));
    items4.add(Nav4ItemClass(
      false,
      'assets/svg/medical-result.svg',
      'Medical',
      3,
    ));
    items4.add(Nav4ItemClass(
      false,
      'assets/svg/users-1.svg',
      'Profile',
      4,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.w - 48,
          height: 72,
          padding: EdgeInsets.only(left: 6, right: 6, top: 1),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(12),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withOpacity(0.2),
          //       offset: Offset(0.0, 8.0),
          //       blurRadius: 10,
          //     ),
          //   ],
          // ),
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(milliseconds: 650),
                curve: Curves.bounceOut,
                top: 0,
                left: ((widget.w - 60) / 5) * pos,
                child: Container(
                  width: ((widget.w - 60) / 5),
                  height: ((widget.w - 60) / 5),
                  child: Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff00e6ff),
                            Color(0xffccffb3),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 1],
                        ),
                        borderRadius: BorderRadius.circular(72),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 1),
                curve: Curves.bounceOut,
                top: 0,
                left: ((widget.w - 60) / 5) * pos,
                child: Container(
                  width: ((widget.w - 60) / 5),
                  height: ((widget.w - 60) / 5),
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 1),
                      width: ((widget.w - 60) / 5),
                      height: ((widget.w - 60) / 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff00e6ff),
                            Color(0xffccffb3),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 1],
                        ),
                        borderRadius: BorderRadius.circular(72),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: items4.map((i) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          items4.forEach((item) => item.isOpen = false);
                          i.isOpen = !i.isOpen;
                          pos = i.pos;
                          context.read<IndexController>().setIndex(pos);
                        },
                      );
                    },
                    child: Nav4Item(
                      w: widget.w,
                      item: i,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Nav4ItemClass {
  bool isOpen;
  String icon;
  String title;
  int pos;

  Nav4ItemClass(this.isOpen, this.icon, this.title, this.pos);
}

class Nav4Item extends StatelessWidget {
  final double w;
  final Nav4ItemClass item;

  const Nav4Item({Key key, this.w, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (w - 60) / 5,
      height: 72,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: item.isOpen ? 30 : 25,
            height: item.isOpen ? 30 : 25,
            child: SvgPicture.asset(
              item.icon,
              fit: BoxFit.cover,
              color: item.isOpen ? Colors.white : Colors.grey[600],
            ),
          ),
          item.isOpen
              ? Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.7,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
