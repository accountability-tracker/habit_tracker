import 'package:flutter/material.dart';

// import '../habits.dart';

class MakeNotifcationsSticky extends StatefulWidget {
  const MakeNotifcationsSticky({
      super.key,
  });

  @override
  _MakeNotifcationsSticky createState() => _MakeNotifcationsSticky();
}

class _MakeNotifcationsSticky extends State<MakeNotifcationsSticky> {

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
              Text(
                "Make notifcations sticky",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              SizedBox(
                height: 4.0,
              ),

              Text(
                "Prevents notifcations from being swiped away.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey
                ),
              ),

            ],
          ),
        ),

        Spacer(),

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
