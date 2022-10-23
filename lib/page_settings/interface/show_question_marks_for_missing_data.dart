import 'package:flutter/material.dart';

// import '../habits.dart';

class ShowQuestionMarksForMissingData extends StatefulWidget {
  const ShowQuestionMarksForMissingData({
      super.key,
  });

  @override
  _ShowQuestionMarksForMissingData createState() => _ShowQuestionMarksForMissingData();
}

class _ShowQuestionMarksForMissingData extends State<ShowQuestionMarksForMissingData> {

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
                "Show question marks for missing data",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),

              const Text(
                "Differentiate days without data from actual lapses. To enter a lapse, toggle twice.",
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
