import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_from_pic_card.dart';

class FruitsAndVegetables extends StatelessWidget {
  const FruitsAndVegetables({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPictureCard(objects: Data.fruitsAndVegetablesData, title: 'Fruits And Vegetables', scaffoldBg: Colors.green.shade100);
  }
}
