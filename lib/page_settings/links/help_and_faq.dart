import 'package:flutter/material.dart';

// import '../habits.dart';

class HelpAndFAQ extends StatefulWidget {
  const HelpAndFAQ({
      super.key,
  });

  @override
  _HelpAndFAQ createState() => _HelpAndFAQ();
}

class _HelpAndFAQ extends State<HelpAndFAQ> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget> [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                "Help & FAQ",
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
