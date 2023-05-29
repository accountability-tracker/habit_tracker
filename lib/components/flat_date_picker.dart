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
        backgroundColor: MaterialStatePropertyAll<Color>(customColors.buttonNormal!),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      ),
      onPressed: () async {
        TimeOfDay? selectedTime = await showTimePicker(
          initialTime: TimeOfDay(hour: int.parse(widget.dateController.text.split(':')[0]), minute: int.parse(widget.dateController.text.split(':')[1])),
          context: context,
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: customColors.background,
                  dialBackgroundColor: customColors.buttonNormal,
                  hourMinuteShape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.selected) ? customColors.textColorLink! : customColors.buttonNormal!),
                  hourMinuteTextColor: customColors.textColor!,
                  dialHandColor: customColors.textColorLink,
                  //hourMinuteTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  dayPeriodTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  helpTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: customColors.textColor!),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  dialTextColor: customColors.textColor!,
                  entryModeIconColor: customColors.textColor,
                  dayPeriodColor: MaterialStateColor.resolveWith(
                      (states) => states.contains(MaterialState.selected) ? customColors.textColorLink! : customColors.buttonNormal!),
                  dayPeriodTextColor: customColors.textColor!,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormal!),
                    foregroundColor: MaterialStateColor.resolveWith((states) => customColors.textColor!),
                    overlayColor: MaterialStateColor.resolveWith((states) => customColors.buttonNormalHover!),
                  )
                )
              ),
              child: child!,
            );
          },
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
        height: 32.0,
        width: 72.0
      ),
    );
  }
}
