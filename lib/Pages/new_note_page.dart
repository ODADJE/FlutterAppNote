import 'package:app_note/Models/note.dart';
import 'package:app_note/Widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class NewNotePage extends StatefulWidget {
  ValueSetter<List<String>> onSave;
  NewNotePage({super.key, required this.onSave});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  String title = "";
  String body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(title.isNotEmpty ? "Title: $title" : "New Note")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              MyTextField(
                hintText: "Title",
                onChanged: (newValue) {
                  setState(() {
                    title = newValue;
                  });
                },
              ),
              MyTextField(
                onChanged: (newValue) {
                  setState(() {
                    body = newValue;
                  });
                },
                hintText: "Your limit is your imagination!",
                size: 18,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
          final note = [title, body];
          widget.onSave(note);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
