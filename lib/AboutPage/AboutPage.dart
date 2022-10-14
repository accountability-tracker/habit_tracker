import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../habits.dart';

import '../components/FlatTextField.dart';
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
        title: Text(
          "About",
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        // width: MediaQuery.of(context).size.width * 0.9,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              "Links",
            ),

            TextButton(
              child: Text("Source code on Github"),
              onPressed: () => _openGithubSourceCode(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft
              ),
            ),

          ],
        ),
      ),
    );
  }
}
