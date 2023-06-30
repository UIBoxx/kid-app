import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final int itemCount;
  final Function(int) onTap;
  final Color Function(int) color;
  final Widget Function(int) child;
  final bool istrue;
  final int crossAccessCount;
  const CustomGrid(
      {super.key,
      required this.itemCount,
      required this.onTap,
      required this.color,
      required this.child,
      required this.istrue,
      required this.crossAccessCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        shrinkWrap: istrue,
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAccessCount,
          childAspectRatio: 1,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  decoration: BoxDecoration(
                      color: color(index),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: child(index)),
            );
            }
          );
        },
      ),
    );
  }
}
