import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_from_pic_card.dart';

class MyVehicles extends StatelessWidget {
  const MyVehicles({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPictureCard(
      objects: Data.vehiclesData,
      title: 'Vehicles',
      scaffoldBg: Colors.grey.shade100,
    );
  }
}