import 'package:flutter/material.dart';
import 'pet_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../frontend_settings.dart';

class ListCardView {
  var allPetsData = [
    {
      'key': '2020-09-11=17:25:57:351',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Jimmy',
        'petProfilePicUrl':
            'https://s.yimg.jp/i/kids/zukan/photo/animal/mammals/0079/640_480.jpg',
        'sex': 'm'
      }
    },
    {
      'key': '2020-09-11=17:25:57:352',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Ryohei',
        'petProfilePicUrl':
            'https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/logo%2Flogo.png?alt=media&token=b41579cc-b641-4e26-9059-6648a752e347',
        'sex': 'm'
      }
    },
    {
      'key': '2020-09-11=17:25:57:353',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Vincent',
        'petProfilePicUrl':
            'https://firebasestorage.googleapis.com/v0/b/furballtales-d0eb8.appspot.com/o/FkkP04fWjCcgy2aLdqxi867U1z53%2FprofileTemporaryImage%2FprofileTemporaryImage.jpg?alt=media&token=8dc9b60b-4762-4cbc-94b9-700f0e1cdd80',
        'sex': 'm'
      }
    },
    {
      'key': '2020-09-11=17:25:57:354',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Anjy',
        'petProfilePicUrl':
            'https://n7.nextpng.com/sticker-png/154/395/sticker-png-pokemon-x-and-y-jigglypuff-wigglytuff-igglybuff-pikachu-pikachu-mammal-dog-like-mammal-vertebrate-cartoon-thumbnail.png',
        'sex': 'm'
      }
    },
    {
      'key': '2020-09-11=17:25:57:355',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Jeff',
        'petProfilePicUrl':
            'https://media-01.creema.net/user/77353/exhibits/7362361/3_6bd4a9adf730b3a22421b7211e318a52_500.jpg',
        'sex': 'm'
      }
    },
    {
      'key': '2020-09-11=17:25:57:356',
      'data': {
        'birthday': '2020-09-11',
        'petName': 'Anny',
        'petProfilePicUrl':
            'https://s.yimg.jp/i/kids/zukan/photo/animal/mammals/0079/640_480.jpg',
        'sex': 'm'
      }
    },
  ];

  @override
  Widget listCardView() {
    return Container(
      color: Color(baseColor),
      height: 315,
      child: PageView(
        // store this controller in a State to save the carousel scroll position
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        children: <Widget>[
          for (var i = 0; i < allPetsData.length; i++)
            Container(
              // giving some mergin
              margin: EdgeInsets.only(top: 15, right: 14, bottom: 25),
              child: PetCard(
                  allPetsData[i]['key'],
                  (allPetsData[i]["data"] as Map<String, String>)["birthday"],
                  (allPetsData[i]['data'] as Map<String, String>)['petName'],
                  (allPetsData[i]['data']
                      as Map<String, String>)['petProfilePicUrl'],
                  (allPetsData[i]['data'] as Map<String, String>)['sex']),
            )
        ],
      ),
    );
  }
}
