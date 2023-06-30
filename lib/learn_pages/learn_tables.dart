import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utils/appbar.dart';

class TableLearn extends StatelessWidget {
  const TableLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle myText= TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green.shade800,);
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: const CustomAppBar(
        title: 'Multiplication Tables',
      ),
      
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 19,
        itemBuilder: (context, i){
          return  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  const Gap(10),
                  Text('Multiplication Table of ${i+2}',style: TextStyle(fontSize: 20, color: Colors.amber.shade800,fontWeight: FontWeight.w800),),
                  const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 375,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        10,
                        (index) => Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('${i+2}', textAlign: TextAlign.center, style: myText,),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('X', textAlign: TextAlign.center, style: myText,),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('${index + 1}', textAlign: TextAlign.center, style: myText,),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('=', textAlign: TextAlign.center, style: myText,),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('${(i+2) * (index + 1)}', textAlign: TextAlign.center, style: myText,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      })
    );
  }
}
