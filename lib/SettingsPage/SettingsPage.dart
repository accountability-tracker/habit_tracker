import 'package:flutter/material.dart';

// Interface options
import "./Interface/ExtendDayAFewHoursPastMidnight.dart";
import "./Interface/EnableSkipDays.dart";

class Page_Settings extends StatefulWidget {
  const Page_Settings({
      super.key,
  });

  @override
  _Page_Settings createState() => _Page_Settings();
}

class _Page_Settings extends State<Page_Settings> {

  bool light = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        // width: MediaQuery.of(context).size.width * 0.9,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              "Interface",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan
              ),
            ),

            SizedBox(
              height: 8.0,
            ),

            const ExtendDayAFewHoursPastMidnight(),

            SizedBox(
              height: 16.0,
            ),

            const EnableSkipDays(),

          ],
        ),
      ),
    );
  }
}
