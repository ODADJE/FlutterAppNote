import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  ValueSetter<String> onChanged;
  String hintText;
  double size;
  MyTextField(
      {super.key,
      required this.hintText,
      this.size = 25,
      required this.onChanged});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (newValue) {
        widget.onChanged(newValue);
      },
      style: TextStyle(fontSize: widget.size),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            TextStyle(fontSize: widget.size, fontWeight: FontWeight.w300),
        border: InputBorder.none,
      ),
      maxLines: null,
      keyboardType: TextInputType.text,
    );
  }
}
