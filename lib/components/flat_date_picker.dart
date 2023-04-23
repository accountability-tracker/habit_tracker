import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';

class FlatDatePicker extends StatefulWidget {
  const FlatDatePicker({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  State<FlatDatePicker> createState() => _FlatDatePicker();
}

class _FlatDatePicker extends State<FlatDatePicker> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(customColors.backgroundCompliment!),
        //shape: BoxShape.rectangle,
      ),
      onPressed: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          initialTime: TimeOfDay(hour: int.parse(widget.dateController.text.split(':')[0]), minute: int.parse(widget.dateController.text.split(':')[1])),
          context: context,
        );
        if (selectedTime == null) return;
        setState(() {
          widget.dateController.text = selectedTime.toString().substring(10,15);
        });
      },
      child: SizedBox(
        child: Row(
          children: [
            Icon(Icons.timer_outlined, color: customColors.textColorSecondary,), 
            Text(widget.dateController.text, style: TextStyle(color: customColors.textColor),)
          ]
        ), 
        height: 36.0, 
        width: 72.0
      ),
    );
  }
}
