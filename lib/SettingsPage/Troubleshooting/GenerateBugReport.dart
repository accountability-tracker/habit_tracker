import 'package:flutter/material.dart';

// import '../habits.dart';

class GenerateBugReport extends StatefulWidget {
  const GenerateBugReport({
      super.key,
  });

  @override
  _GenerateBugReport createState() => _GenerateBugReport();
}

class _GenerateBugReport extends State<GenerateBugReport> {
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
                "Generate bug report",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
