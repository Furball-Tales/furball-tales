import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FourthNav extends StatefulWidget {
  final double w;

  const FourthNav({Key key, this.w}) : super(key: key);
  @override
  _FourthNavState createState() => _FourthNavState();
}

class _FourthNavState extends State<FourthNav> {
  List<Nav4ItemClass> items4 = List<Nav4ItemClass>();
  int pos = 0;

  @override
  void initState() {
    super.initState();

    items4.add(Nav4ItemClass(true, Icons.home, 'Home', 0));
    items4.add(Nav4ItemClass(false, Icons.perm_media, 'Codepen', 1));
    items4.add(Nav4ItemClass(false, Icons.local_hospital, 'Edit', 2));
    items4.add(Nav4ItemClass(false, Icons.perm_identity, 'Folder', 3));
    items4.add(Nav4ItemClass(false, Icons.home, 'Profile', 4));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.w - 48,
        height: 84,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0.0, 8.0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: Duration(milliseconds: 600),
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
                          Color(0xff13E147),
                          Color(0xff2C86E0),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(72),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceOut,
              top: 0,
              left: ((widget.w - 60) / 5) * pos,
              child: Container(
                width: ((widget.w - 60) / 5),
                height: ((widget.w - 60) / 5),
                child: Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: ((widget.w - 60) / 5),
                    height: ((widget.w - 60) / 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff13E147),
                          Color(0xff2C86E0),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
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
                    setState(() {
                      items4.forEach((item) => item.isOpen = false);
                      i.isOpen = !i.isOpen;
                      pos = i.pos;
                    });
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
    );
  }
}

class Nav4ItemClass {
  bool isOpen;
  IconData icon;
  String title;
  int pos;

  Nav4ItemClass(this.isOpen, this.icon, this.title, this.pos);
}

class Nav4Item extends StatelessWidget {
  final double w;
  final Nav4ItemClass item;
  final IconData icon;

  const Nav4Item({Key key, this.w, this.item, this.icon}) : super(key: key);

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
            width: item.isOpen ? 30 : 24,
            height: item.isOpen ? 30 : 24,
            color: item.isOpen ? Colors.white : Colors.grey,
            child: NeumorphicIcon(
              Icons.home,
              size: 30,
            ),
          ),
          item.isOpen
              ? Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    height: 1.8,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
