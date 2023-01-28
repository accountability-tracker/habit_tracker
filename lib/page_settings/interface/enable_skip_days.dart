import 'package:flutter/material.dart';

// import '../habits.dart';

class EnableSkipDays extends StatefulWidget {
  const EnableSkipDays({
    super.key,
  });

  @override
  State<EnableSkipDays> createState() => _EnableSkipDays();
}

class _EnableSkipDays extends State<EnableSkipDays> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                "Enable skip days",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "Toggle twice to add a skip instead of a checkmark. Skips keep your score unchanged and don't break your streak.",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        const Spacer(),
        Switch(
          // This bool value toggles the switch.
          value: light,
          activeColor: Colors.red,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              light = value;
            });
          },
        ),
      ],
    );
  }
}
