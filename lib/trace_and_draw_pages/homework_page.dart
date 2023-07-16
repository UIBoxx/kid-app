import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kidzworld/trace_and_draw_pages/trace_card.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/hive_db.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({super.key});

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  final TextEditingController _inputController = TextEditingController();

  final _myBox = Hive.box('home_work');

  HomeWorkDb db = HomeWorkDb();

  List<List<dynamic>> myHomework = [
  ];

  @override
  void initState() {
    if (_myBox.get("HOMEWORK") == null) {
      db.createInitialData();
      
    } else {
      db.loadDb();
    }
      int length = db.myHomework.length;
      myHomework = List.generate(length, (_) => [0, <List<Offset>>[]]);
    super.initState();
  }

  void updateIsDone(int index, int newValue) {
    setState(() {
      myHomework[index][0] = newValue;
    });
  }

  void updateOffset(int index, List<List<Offset>> newOffset) {
    setState(() {
      myHomework[index][1] = newOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a confirmation dialog when the user tries to go back
        bool confirmExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Navigation'),
              content: const Text(
                  'Leaving this page will result in the loss of all your completed tasks. Are you sure you want to proceed?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false); // User chose not to exit
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true); // User chose to exit
                  },
                ),
              ],
            );
          },
        );

        return confirmExit; // Return the user's choice (true or false)
      },
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: const CustomAppBar(
          title: 'Trace Them',
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink.shade400,
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add a task'),
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _inputController,
                          decoration: const InputDecoration(
                              hintText: 'Enter a letters separated by comma'),
                        ),
                        const Gap(30),
                        Text(
                          '**Longpress on card to delete.',
                          style: TextStyle(
                              color: Colors.red.shade400, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        String input =
                            _inputController.text; // Get the entered CSV input
                        List<String> values = input.split(
                            ','); // Split the input using commas as separators

                        setState(() {
                          for (String value in values) {
                            db.myHomework.add([
                              value.trim(),
                            ]);
                            db.updateDb();
                            myHomework.add([
                              0,
                              <List<Offset>>[]
                            ]); // Add each value to the homework list
                          }
                        });

                        _inputController.clear(); // Clear the text field
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: db.myHomework.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  setState(() {
                    db.myHomework.removeAt(index);
                    myHomework.removeAt(index);
                  });
                  db.updateDb();
                },
                onTap: () {
                  List<List<Offset>> lines = myHomework[index][1];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TraceCard(
                        value: db.myHomework[index][0].toString(),
                        lines: lines,
                        updateIsDone: (newValue) {
                          updateIsDone(index, newValue);
                        },
                        updateOffset: (newOffset) {
                          updateOffset(index, newOffset);
                        },
                      ),
                    ),
                  );
                },
                child: Card(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      db.myHomework[index][0].toString().length > 3
                          ? "${db.myHomework[index][0].toString().substring(0, 3)}.."
                          : db.myHomework[index][0].toString(),
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.green.shade300,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: myHomework[index][0] == 0
                            ? Colors.transparent
                            : Colors.green,
                      ),
                      child: Text(
                        myHomework[index][0] == 0 ? '' : 'Completed',
                        style: TextStyle(
                          color: myHomework[index][0] == 0
                              ? Colors.red
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
              );
            },
          ),
        ),
      ),
    );
  }
}
