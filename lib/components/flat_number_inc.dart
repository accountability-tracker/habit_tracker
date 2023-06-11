import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';

class FlatNumIncField extends StatefulWidget {
  const FlatNumIncField({super.key, required this.textController, required this.frequencyValue});

  final TextEditingController textController;
  final String frequencyValue;

  @override
  State<FlatNumIncField> createState() => _FlatNumIncField();
}

class _FlatNumIncField extends State<FlatNumIncField> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48.0,
            height: 48.0,
            child: InkWell(
              child: Container(
                child: Icon(Icons.add),
                decoration: BoxDecoration(shape: BoxShape.circle, color: customColors.backgroundCompliment),
              ),
              onTap: () {
                if (widget.frequencyValue != 'Per Day' && !(widget.frequencyValue == 'Per Week' && widget.textController.text == '7')) {
                  widget.textController.text = (int.parse(widget.textController.text) + 1).toString();
                }
              }
            ),
          ),
          SizedBox(
            width: 36.0,
            height: 48.0,
            child: TextField(
              enabled: false,
              textAlign: TextAlign.center,
              controller: widget.textController,
              style: TextStyle(color: customColors.textColor, fontSize: 16),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: customColors.background, 
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              ),
            )
          ),
          SizedBox(
            width: 48.0,
            height: 48.0,
            child: InkWell(
              child: Container(
                child: Icon(Icons.remove),
                decoration: BoxDecoration(shape: BoxShape.circle, color: customColors.backgroundCompliment),  
              ),
              onTap: () {
                if (widget.textController.text != '1') {
                  widget.textController.text = (int.parse(widget.textController.text) - 1).toString();
                }
              }
            ),
          ),
        ]
    );
  }
}
