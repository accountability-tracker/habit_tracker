import 'package:flutter/material.dart';

// import '../habits.dart';

class ExtendDayAFewHoursPastMidnight extends StatefulWidget {
  const ExtendDayAFewHoursPastMidnight({
      super.key,
  });

  @override
  _ExtendDayAFewHoursPastMidnight createState() => _ExtendDayAFewHoursPastMidnight();
}

class _ExtendDayAFewHoursPastMidnight extends State<ExtendDayAFewHoursPastMidnight> {

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
                "Extend day a few hours past midnight",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),


              const Text(
                "Wait until 5:00am to show a new day. Useful if you typically go to sleep after midnight.",
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
