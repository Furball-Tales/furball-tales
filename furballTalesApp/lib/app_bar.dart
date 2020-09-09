import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double barHeight = 50.0;
  bool back;

  GradientAppBar(this.title, this.back);

  backButton(BuildContext context) {
    if (back) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                )),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Container(),
          ),
        ],
      );
    } else {
      return Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: backButton(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff00e6ff), Color(0xffccffb3)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.5, 4.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
