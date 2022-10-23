import 'package:flutter/material.dart';

// import '../habits.dart';

class ExportFullBackup extends StatefulWidget {
  const ExportFullBackup({
      super.key,
  });

  @override
  _ExportFullBackup createState() => _ExportFullBackup();
}

class _ExportFullBackup extends State<ExportFullBackup> {
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
                "Export full backup",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              SizedBox(
                height: 4.0,
              ),

              Text(
                "Generates a file that contains all your data. This file can be imported back.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
