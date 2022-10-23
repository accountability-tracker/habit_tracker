import 'package:flutter/material.dart';

import 'package:habit_tracker/page_about/page_about.dart';
// import '../habits.dart';

class About extends StatefulWidget {
  const About({
      super.key,
  });

  @override
  _About createState() => _About();
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget> [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          alignment: Alignment.centerLeft,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                child: const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Page_About()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
