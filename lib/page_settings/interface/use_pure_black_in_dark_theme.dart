import 'package:flutter/material.dart';

// import '../habits.dart';

class UsePureBlackInDarkTheme extends StatefulWidget {
  const UsePureBlackInDarkTheme({
      super.key,
  });

  @override
  _UsePureBlackInDarkTheme createState() => _UsePureBlackInDarkTheme();
}

class _UsePureBlackInDarkTheme extends State<UsePureBlackInDarkTheme> {

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
                "Use pure black in dark theme",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),

              const Text(
                "Replaces the none pure black background with pure black in dark theme. Reduces battery usage in phones with amoled displays.",
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
