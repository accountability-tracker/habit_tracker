import 'package:flutter/material.dart';

// import '../habits.dart';

class ImportData extends StatefulWidget {
  const ImportData({
      super.key,
  });

  @override
  _ImportData createState() => _ImportData();
}

class _ImportData extends State<ImportData> {
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
                "Import data",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),

              const Text(
                "Supports full backups exported by this app.",
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
