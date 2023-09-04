import 'package:app_note/Models/note.dart';
import 'package:app_note/Pages/new_note_page.dart';
import 'package:app_note/Pages/view_note_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  List notes = [];

  @override
  void initState() {
    // TODO: implement initState
    if (_myBox.get("note") == null) {
      notes = [
        ["First note", "This app is created with heart by OKS "]
      ];
    } else {
      notes = _myBox.get("note");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notes"),
      ),
      body: notes.length == 0
          ? Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ViewNotePage(
                        note: notes[index],
                        index: index,
                        ondelete: deleteNote,
                      );
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notes[index][0],
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              notes[index][1],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: notes.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (contex) {
            return NewNotePage(onSave: addNote);
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addNote(List<String> note) async {
    if (note[0].isEmpty) {
      return;
    }
    setState(() {
      notes.add(note);
      _myBox.put("note", notes);
    });
  }

  deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
      _myBox.put("note", notes);
    });
  }
}
