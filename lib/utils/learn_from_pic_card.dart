import 'package:flutter/material.dart';
import 'package:kidzworld/utils/appbar.dart';

class CustomPictureCard  extends StatelessWidget {

  final List objects;
  final String title;
  final Color scaffoldBg;

  const CustomPictureCard ({super.key, required this.objects,required this.title, required this.scaffoldBg});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: scaffoldBg,
        appBar: CustomAppBar(
        title: title,
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: objects.length,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1),
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${objects[index][0]}',
                        style: const TextStyle(fontSize: 60),
                      ),
                      Text(
                        '${objects[index][1]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.amber.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              );
            },
          ),
        ));
  }
}
