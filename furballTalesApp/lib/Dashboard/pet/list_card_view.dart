import 'package:flutter/material.dart';
import 'pet_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../get_allPetsData.dart';

class ListCardView {
  @override
  Widget listCardView() {
    return Container(
      color: Color(baseColor),
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
                margin: EdgeInsets.only(top: 15, right: 14, bottom: 20),
                child: PetCard(
                  allPetsData[i]['key'],
                  '${allPetsData[i]["data"]["birthday"]}',
                  '',
                  '${allPetsData[i]['data']['petName']}',
                  '${allPetsData[i]['data']['petProfilePicUrl']}',
                  '${allPetsData[i]['data']['sex']}',
                ))
        ],
      ),
    );
  }
}
