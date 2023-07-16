import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final dynamic trailing;
  final void Function()? function;
  final void Function()? alert;

  const CustomAppBar(
      {Key? key, required this.title, this.trailing, this.function, this.alert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.pink.shade400,
      elevation: 0,
      actions: trailing != null
          ? [
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: alert,
                  onLongPress: function,
                  child: Text(
                    trailing.toString(),
                    style: TextStyle(
                      color: Colors.pink.shade400,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBarWithTimmer extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? trailing;
  final void Function()? refresh;
  final void Function()? undo;
  final void Function()? timer;
  final int time;
  final bool isRunning;

  const CustomAppBarWithTimmer(
      {super.key, required this.title,
      this.trailing,
      this.refresh,
      this.undo,
      this.timer,
      required this.time,
      required this.isRunning});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.pink.shade400,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        isRunning
            ? TextButton(onPressed: timer, child: Text('⏱️${time.toString()}s', style: TextStyle(color: Colors.amber.shade800, fontSize: 18)))
            : const Text(''),
        TextButton(onPressed: refresh, child: const Text('Clear All')),
        const Gap(10),
        GestureDetector(onTap: undo, child: const Icon(Icons.undo)),
        const Gap(5),
        if (trailing != null) trailing!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
