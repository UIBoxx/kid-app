import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mydialogues {
  static loadeingScreen() {
    Get.dialog(const Center(
      child: CircularProgressIndicator(),
    ));
  }

  static resultDialogue(
      String award, String title, String subtile, VoidCallback action, String actionText, Color bg) {
    return AlertDialog(
      backgroundColor: bg,
      title: Column(
        children: [
          Text(award, style: const TextStyle(fontSize: 50)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.green),
          ),
          Text(subtile, textAlign: TextAlign.center),
        ],
      ),
      actions: [
        TextButton(
          onPressed: action,
          child: Text(actionText),
        ),
      ],
    );
  }
}
