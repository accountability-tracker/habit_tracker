import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerCust extends StatefulWidget {
  const DrawerCust({super.key});

  @override
  State<DrawerCust> createState() => _DrawerCustState();
}

class _DrawerCustState extends State<DrawerCust> {

  final List<String> test_list = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(26, 26, 26, 1.0),

        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            const SizedBox(
              height: 64.0,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text('Drawer Header'),
              ),
            ),

            for(var item in test_list)
            ListTile(
              title: Text('Item ' + item),
              onTap: () {
                // Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}
