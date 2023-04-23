import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';

class FlatTextField extends StatefulWidget {
  const FlatTextField({super.key, required this.textController, this.hintText, this.keyboardType,});

  final TextEditingController textController;
  final String? hintText;
  final String? keyboardType;

  @override
  State<FlatTextField> createState() => _FlatTextField();
}

class _FlatTextField extends State<FlatTextField> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    TextInputType keyboard = TextInputType.text;
    if (widget.keyboardType == 'num') {
      keyboard = TextInputType.number;
    }

    return TextField(
      controller: widget.textController,
      keyboardType: keyboard,
      style: TextStyle(color: customColors.textColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        filled: true,
        fillColor: customColors.backgroundCompliment, // const Color.fromRGBO(41, 41, 41, 1.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.0,
            color: customColors.backgroundCompliment!,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 16.0, color: customColors.textColorSecondary),
      ),
    );
  }
}
