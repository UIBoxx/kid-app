import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final dynamic trailing;

  const CustomAppBar({Key? key, required this.title, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.pink.shade400,
      elevation: 0,
      actions: trailing != null ? [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            trailing.toString(),
            style: TextStyle(
              color: Colors.pink.shade400,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
