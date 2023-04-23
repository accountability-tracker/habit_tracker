import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:habit_tracker/theme.dart';

class FlatSwitch extends StatefulWidget {
  const FlatSwitch({super.key, required this.reminderController});

  final TextEditingController reminderController;

  @override
  State<FlatSwitch> createState() => _FlatSwitch();
}

class _FlatSwitch extends State<FlatSwitch> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return FlutterSwitch(
      value: widget.reminderController.text == 't',
      inactiveColor: customColors.textColorSecondary!,
      activeColor: customColors.switchColor!,
      activeToggleColor: customColors.toggleColor,
      height: 25,
      width: 50,
      padding: 0.0,

      onToggle: (value) {
        setState(() {
          if (value) {
            widget.reminderController.text = 't';
          }
          else {
            widget.reminderController.text = 'f';
          }
        }); 
      }, 
    );
  }
}
