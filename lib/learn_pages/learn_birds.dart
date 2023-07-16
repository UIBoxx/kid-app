import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_from_pic_card.dart';

class MyBirds extends StatelessWidget {
  const MyBirds({super.key});

  @override
  Widget build(BuildContext context) {
    return PictureCard(
      objects: Data.birdsData,
      title: 'Birds',
      scaffoldBg: Colors.brown.shade100,
    );
  }
}
