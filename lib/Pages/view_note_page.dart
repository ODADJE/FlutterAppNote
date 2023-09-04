import 'package:app_note/Models/note.dart';
import 'package:flutter/material.dart';

class ViewNotePage extends StatelessWidget {
  ViewNotePage(
      {super.key,
      required this.note,
      required this.index,
      required this.ondelete});

  final List note;
  final int index;
  ValueSetter<int> ondelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title: ${note[0]}"),
        actions: [
          IconButton(
              onPressed: () {
                _showMyDialogue(context, note);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note[0],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              note[1],
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      )),
    );
  }

  Future<void> _showMyDialogue(BuildContext context, List note) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete note"),
            content: SingleChildScrollView(
              child: Text("Note : '${note[0]}' will be deleted!"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ondelete(index);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("DELETE"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CANCEL"),
              ),
            ],
          );
        });
  }
}
