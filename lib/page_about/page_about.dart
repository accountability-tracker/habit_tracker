import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/components/flat_textfield.dart';
// import '../components/FlatDropdown.dart';

class Page_About extends StatefulWidget {
  const Page_About({
      super.key,
  });

  @override
  _Page_About createState() => _Page_About();
}

class _Page_About extends State<Page_About> {

  void _openGithubSourceCode() async {
    final Uri github_url = Uri(scheme: 'https', host: 'www.github.com', path: 'accountability-tracker/habit_tracker');
    if (!await launchUrl(
        github_url,
        mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $github_url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        // width: MediaQuery.of(context).size.width * 0.9,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const Text(
              "Habit Tracker",
              style: TextStyle(
                color: Colors.blue
              ),
            ),

            const Text(
              "version 1.0.0",
            ),

            const SizedBox(height: 16.0,),

            const Text(
              "Links",
              style: TextStyle(
                color: Colors.blue
              ),
            ),

            TextButton(
              child: const Text("Source code on Github"),
              onPressed: () => _openGithubSourceCode(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft
              ),
            ),

            const SizedBox(height: 16.0,),

            const Text(
              "Developers",
              style: TextStyle(
                color: Colors.blue
              ),
            ),

            const Text(
              "@clearfeld",
            ),
            const Text(
              "@AaronPatterson1",
            ),

          ],
        ),
      ),
    );
  }
}
