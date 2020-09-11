import 'package:flutter/material.dart';
import 'pet_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ListCardView {
  var itemList = [
    'one',
    'two',
    'three',
    'for',
    'five',
    'six',
  ];
  var photoList = [
    'https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347',
    'https://www.natgeofineart.com/wp-content/uploads/2018/05/2496735_Vitale_2800px.jpg',
    'https://i.guim.co.uk/img/media/dd703cd39013271a45bc199fae6aa1ddad72faaf/0_0_2000_1200/master/2000.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=178a9434c272d5a067353f57a30f58ed',
    'https://n7.nextpng.com/sticker-png/154/395/sticker-png-pokemon-x-and-y-jigglypuff-wigglytuff-igglybuff-pikachu-pikachu-mammal-dog-like-mammal-vertebrate-cartoon-thumbnail.png',
    'https://media-01.creema.net/user/77353/exhibits/7362361/3_6bd4a9adf730b3a22421b7211e318a52_500.jpg',
    'https://s.yimg.jp/i/kids/zukan/photo/animal/mammals/0079/640_480.jpg',
  ];

  @override
  Widget listCardView() {
    return Container(
      height: 315,
      child: PageView(
        // store this controller in a State to save the carousel scroll position
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        children: <Widget>[
          for (var i = 0; i < itemList.length; i++)
            Container(
              // giving some mergin
              margin: EdgeInsets.only(right: 10, bottom: 10),
              child: PetCard(itemList[i], photoList[i]),
            )
        ],
      ),
    );
  }
}
