// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/theme.dart';

class ColorSelect extends StatefulWidget {
  ColorSelect({super.key, required this.currentColor, required this.customColor, });

  TextEditingController currentColor;
  TextEditingController customColor;

  @override
  State<ColorSelect> createState() => _ColorSelect();
}

class _ColorSelect extends State<ColorSelect> {
  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    bool customColorSelected = false;
    if (widget.currentColor.text != '0xfff16567' &&
        widget.currentColor.text != '0xff2ec977' &&
        widget.currentColor.text != '0xff5666f3' &&
        widget.currentColor.text != '0xfff7f186' &&
        widget.currentColor.text != '0xff9186f4') {
          customColorSelected = true;
    }

    return Row(
      children: <Widget>[ 
        InkWell(
          child: Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle, 
                color: 
                  Color(0xfff16567), 
                  border: widget.currentColor.text == '0xfff16567' ? Border.all(width: 2.0, color: Colors.amber) : null
              ),
            width: 36.0,
            height: 36.0,
          ),
          onTap: () {
            setState(() {
              widget.currentColor.text = '0xfff16567';
            });
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        InkWell(
          child: Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle, 
                color: Color(0xff2ec977),
                border: widget.currentColor.text == '0xff2ec977' ? Border.all(width: 2.0, color: Colors.amber) : null
              ),
            width: 36.0,
            height: 36.0,
            
          ),
          onTap: () {
            setState(() {
              widget.currentColor.text = '0xff2ec977';
            });
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        InkWell(
          child: Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle, 
                color: Color(0xff5666f3),
                border: widget.currentColor.text == '0xff5666f3' ? Border.all(width: 2.0, color: Colors.amber) : null
              ),
            width: 36.0,
            height: 36.0,
          ),
          onTap: () {
            setState(() {
              widget.currentColor.text = '0xff5666f3';
            });
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        InkWell(
          child: Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle, 
                color: Color(0xfff7f186),
                border: widget.currentColor.text == '0xfff7f186' ? Border.all(width: 2.0, color: Colors.amber) : null
              ),
            width: 36.0,
            height: 36.0,
          ),
          onTap: () {
            setState(() {
              widget.currentColor.text = '0xfff7f186';
            });
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        InkWell(
          child: Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle, 
                color: Color(0xff9186f4),
                border: widget.currentColor.text == '0xff9186f4' ? Border.all(width: 2.0, color: Colors.amber) : null
              ),
            width: 36.0,
            height: 36.0,
          ),
          onTap: () {
            setState(() {
              widget.currentColor.text = '0xff9186f4';
            });
          },
        ),
        const SizedBox(
          width: 16.0,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: customColors.background,
                  surfaceTintColor: customColors.background,
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: Color(int.parse(widget.customColor.text)),
                      onColorChanged: (Color color) {
                        setState(() => widget.customColor.text = color.value.toString());
                      },
                    ),
                    // Use Material color picker:
                    //
                    // child: MaterialPicker(
                    //   pickerColor: pickerColor,
                    //   onColorChanged: changeColor,
                    //   showLabel: true, // only on portrait mode
                    // ),
                    //
                    // Use Block color picker:
                    //
                    // child: BlockPicker(
                    //   pickerColor: currentColor,
                    //   onColorChanged: changeColor,
                    // ),
                    //
                    // child: MultipleChoiceBlockPicker(
                    //   pickerColors: currentColors,
                    //   onColorsChanged: changeColors,
                    // ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text('Got it', style: TextStyle(color: customColors.textColorLink)),
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(customColors.backgroundCompliment)),
                      onPressed: () {
                        setState(() {
                          widget.currentColor.text = widget.customColor.text; 
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              color: Color(int.parse(widget.customColor.text)),
              border: customColorSelected ? Border.all(width: 2.0, color: Colors.amber) : null
            ),
            width: 36.0,
            height: 36.0,
            child: const Icon(Icons.add),
          ),
        ),
      ]
    );
  }
}
