import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';

class FlatTextField extends StatefulWidget {
  const FlatTextField({super.key, required this.textController, this.hintText});

  final TextEditingController textController;
  final String? hintText;

  @override
  State<FlatTextField> createState() => _FlatTextField();
}

class _FlatTextField extends State<FlatTextField> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return TextField(
      controller: widget.textController,
      style: TextStyle(color: customColors.textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: customColors.background, // const Color.fromRGBO(41, 41, 41, 1.0),
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
      ),
    );
  }
}
