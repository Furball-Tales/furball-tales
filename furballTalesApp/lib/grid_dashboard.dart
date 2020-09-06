import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './memo.dart';
import 'custom_card.dart';
import 'icon_card.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  var itemList = ['one', 'two', 'three', 'for', 'five'];
  var photoList = [
    'assets/top_image.png',
    'assets/logo.png',
    'assets/google_logo.png',
    'assets/login_background.png',
    'assets/top_image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: <Widget>[
          Top(),
          IconCard(Icons.graphic_eq, "Food", 0xffed622b),
          cardPageView(),
          MyItems(Icons.graphic_eq, "Walk", 0xffed622b),
          MyItems(Icons.graphic_eq, "Goods", 0xffed622b),
          MyItems(Icons.graphic_eq, "Clothes", 0xffed622b),
          // Memo(),
        ],
        staggeredTiles: [
          StaggeredTile.fit(2),
          StaggeredTile.extent(1, 200),
          StaggeredTile.extent(1, 220),
          StaggeredTile.extent(2, 140),
          StaggeredTile.extent(1, 130),
          StaggeredTile.extent(1, 130),
        ],
      ),
    );
  }

  Material MyItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.grey[200],
      borderRadius: BorderRadius.circular(60),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //text
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: Color(color),
                        fontSize: 20,
                      ),
                    ),
                  ),

                  //icon
                  Material(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Material Top() {
    return Material(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.grey[200],
      borderRadius: BorderRadius.circular(5),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.40),
            child: Container(
                width: 115.0,
                height: 115.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSxDoD5caxFUy_dn0w6wl01m882CeJHNVOCRg&usqp=CAU'),
                    ))),
          ),
          Flexible(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.10),
                  child: Text(
                    'Good Morning, Sir.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Card(
                    child: Container(
                      height: 100,
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 4,
                          ),
                          Text('Name: Benjamin'),
                          Text('Sex: ♂'),
                          Text('Age: 3 months'),
                        ],
                      ),
                    ),
                    elevation: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardPageView() {
    return Container(
      height: 315,
      child: PageView(
        // store this controller in a State to save the carousel scroll position
        controller: PageController(viewportFraction: 0.8),
        children: <Widget>[
          for (var i = 0; i < itemList.length; i++)
            Container(
              // 間隔が狭くなるので若干marginを付けてあげる
              margin: EdgeInsets.only(right: 10, bottom: 20),
              child: CustomCard(itemList[i], photoList[i]),
            )
        ],
      ),
    );
  }
}
