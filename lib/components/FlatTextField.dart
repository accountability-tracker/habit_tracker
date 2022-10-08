import 'package:flutter/material.dart';

class FlatTextField extends StatefulWidget {
  const FlatTextField({
      super.key,
      required this.textController,
      this.hintText
  });

  final TextEditingController textController;
  final String? hintText;

  @override
  State<FlatTextField> createState() => _FlatTextField();
}

class _FlatTextField extends State<FlatTextField> {
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.textController,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(41, 41, 41, 1.0),

        border: InputBorder.none,

        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
    );
  }
}
