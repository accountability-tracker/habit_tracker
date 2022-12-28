import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';

typedef void SetValueStringCallback(String? valueArg);

class FlatDropdown extends StatefulWidget {
  const FlatDropdown({
    super.key,
    required this.value,
    required this.onValueChanged,
    required this.items,
  });

  final String value;
  final SetValueStringCallback onValueChanged;

  // TODO(clearfeld): allow for enums later
  final List<String> items;

  @override
  State<FlatDropdown> createState() => _FlatDropdown();
}

class _FlatDropdown extends State<FlatDropdown> {
  // Son({
  //     @
  // });

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: customColors.background, //  Color.fromRGBO(41, 41, 41, 1.0),
        //background color of dropdown button
        // border: Border.all(color: Colors.black38, width:3), //border of dropdown button
        // borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
        // boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
        //   BoxShadow(
        //     color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
        //     blurRadius: 5) //blur radius of shadow
        // ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: DropdownButton(
          value: widget.value,
          icon: const Icon(Icons.arrow_downward),
          onChanged: (String? valueArg) {
            widget.onValueChanged(valueArg);
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),

          iconEnabledColor: customColors.text_color, //Icon color
          style: TextStyle(
            color: customColors.text_color, //Font color
            fontSize: 16, //font size on dropdown button
          ),

          dropdownColor: Colors.redAccent, //dropdown background color
          underline: Container(), //remove underline
          isExpanded: true, //make true to make width 100%
        ),
      ),
    );
  }
}
