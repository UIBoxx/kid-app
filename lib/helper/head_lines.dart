import 'package:flutter/material.dart';

class HeadLines{

  static headLine({required String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800),
            ),
          ),
          Divider(
            thickness: 3,
            indent: 20,
            endIndent: 100,
            color: Colors.pink.shade400,
          ),
      ],
    );
  }
}