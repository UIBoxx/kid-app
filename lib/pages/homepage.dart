import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kidzworld/navbar/about.dart';
import 'package:kidzworld/navbar/game.dart';
import 'package:kidzworld/navbar/home.dart';
import 'package:kidzworld/navbar/learn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages =  <Widget>[
    const MyHome(),
    const MyLearn(),
    const MyGame(),
    const MyAbout(),
  ];

  int index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: pages[index],
      bottomNavigationBar: GNav(
        haptic: true,
        tabBorderRadius: 5,
        curve: Curves.easeIn,
        selectedIndex: 0,
        gap: 8,
        duration: const Duration(milliseconds: 300),
        iconSize: 20,
        activeColor: Colors.amber.shade400,
        tabBackgroundColor: const Color.fromARGB(117, 224, 222, 217),
        backgroundColor: Colors.pink.shade800,
        color: Colors.white,
        style: GnavStyle.google,
        tabMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        tabs: const [
          GButton(
            icon: FontAwesomeIcons.house,
            text: 'Home',
          ),
          GButton(
            icon: FontAwesomeIcons.graduationCap,
            text: 'Learn',
          ),
          GButton(
            icon: FontAwesomeIcons.gamepad,
            text: 'Fun',
          ),
          GButton(
            icon: Icons.info,
            text: 'About',
          )
        ],
        onTabChange: (value) {
          setState(() {
          index=value;
          });
        },
      ),
    );
  }
}
