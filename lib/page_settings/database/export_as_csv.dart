import 'package:flutter/material.dart';

// import '../habits.dart';

class ExportAsCSV extends StatefulWidget {
  const ExportAsCSV({
      super.key,
  });

  @override
  _ExportAsCSV createState() => _ExportAsCSV();
}

class _ExportAsCSV extends State<ExportAsCSV> {
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
                "Export as CSV",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),

              const Text(
                "Generates files that be opened by spreadsheet software such as Micorsoft Execel, OpenOffice Calc, (CC), or Google Sheets. This file cannot be imported back.",
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
