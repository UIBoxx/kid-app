import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_from_pic_card.dart';


class MyAnimals extends StatelessWidget {
  const MyAnimals({super.key});
  @override
  Widget build(BuildContext context) {
    return PictureCard(objects: Data.animalsData, title: 'Animals', scaffoldBg: Colors.yellow.shade100);
  }
}
