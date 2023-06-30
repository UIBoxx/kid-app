import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomChoice extends StatelessWidget {
  void Function()? function;
  String text;
  double height;
  double width;
  CustomChoice({super.key, required this.function,required this.text,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onTap: function,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Center(
              child: Text(text, style: TextStyle(fontSize: 40, color: Colors.green.shade500,fontWeight: FontWeight.bold),))),
    );
  }
}