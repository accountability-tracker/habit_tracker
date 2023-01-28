import 'package:flutter/material.dart';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:habit_tracker/habits.dart';

// import 'package:habit_tracker/components/flat_textfield.dart';
// import '../components/FlatDropdown.dart';

class PageAbout extends StatefulWidget {
  const PageAbout({
    super.key,
  });

  @override
  State<PageAbout> createState() => _PageAbout();
}

class _PageAbout extends State<PageAbout> {
  void _openGithubSourceCode() async {
    final Uri githubUrl =
        Uri(scheme: 'https', host: 'www.github.com', path: 'accountability-tracker/habit_tracker');
    if (!await launchUrl(
      githubUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $githubUrl';
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
              style: TextStyle(color: Colors.blue),
            ),
            const Text(
              "version 0.0.1",
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              "Links",
              style: TextStyle(color: Colors.blue),
            ),
            TextButton(
              onPressed: () => _openGithubSourceCode(),
              style:
                  TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
              child: const Text("Source code on Github"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const Text(
              "Developers",
              style: TextStyle(color: Colors.blue),
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
