import 'package:flutter/material.dart';

// import '../habits.dart';

class CustomizeNotifcations extends StatefulWidget {
  const CustomizeNotifcations({
    super.key,
  });

  @override
  State<CustomizeNotifcations> createState() => _CustomizeNotifcations();
}

class _CustomizeNotifcations extends State<CustomizeNotifcations> {
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
                "Customize notifcations",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                "Change sound, vibration, light and other notifcation settings. (TODO show modal)",
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
