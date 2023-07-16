import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/hive_db.dart';

class OthersPage extends StatefulWidget {
  const OthersPage({Key? key}) : super(key: key);

  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  final _myOtherBox = Hive.box('home_work');

  OthersDB db = OthersDB();

  List<Map<String, dynamic>> others = [];

  @override
  void initState() {

    if (_myOtherBox.get("OTHERS") == null) {
      db.createInitialOtherData();
      
    } else {
      db.loadOtherDb();
    }
    super.initState();
  }

  TextEditingController nameController = TextEditingController();

  Future<XFile?> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  void _showAddDialog() async {
    final pickedImage = await _pickImage();
    if (pickedImage != null) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Data'),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.file(File(pickedImage.path)),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                    ),
                  ),
                  const Gap(10),
                  Text(
                    '**Longpress on card to delete.',
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    db.others.add({
                      'imageFile': pickedImage.path,
                      'name': nameController.text,
                    });
                    nameController.clear();
                  });
                  db.updateOtherDb();
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: const CustomAppBar(
        title: 'Others',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade800,
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: db.others.isEmpty?const Center(child: Text('Click on + to add items.'),):Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: db.others.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  db.others.removeAt(index);
                });
                db.updateOtherDb();
              },
              onTap: () async {
                await flutterTts.speak(db.others[index]['name'].toUpperCase());
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(
                        File(db.others[index]['imageFile']),
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      db.others[index]['name'].length > 12
                          ? '${db.others[index]['name'].substring(0, 12)}...'
                          : db.others[index]['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.amber.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
