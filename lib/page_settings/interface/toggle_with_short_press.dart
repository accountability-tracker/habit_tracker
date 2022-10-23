import 'package:flutter/material.dart';

// import '../habits.dart';

class ToggleWithShortPress extends StatefulWidget {
  const ToggleWithShortPress({
      super.key,
  });

  @override
  _ToggleWithShortPress createState() => _ToggleWithShortPress();
}

class _ToggleWithShortPress extends State<ToggleWithShortPress> {

  bool light = true;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget> [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              const Text(
                "Toggle with short press",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),

              const Text(
                "Put checkmarks with a single tap isntead of a press and hold.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey
                ),
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
