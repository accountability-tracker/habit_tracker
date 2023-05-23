import 'package:flutter/material.dart';
import 'package:habit_tracker/theme.dart';
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
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
        ),
        backgroundColor: customColors.navbarBackground,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        // margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        color: customColors.background,
        // width: MediaQuery.of(context).size.width * 0.9,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Habit Tracker",
              style: TextStyle(color: customColors.progressBarForeground),
            ),
            const Text(
              "version 0.0.4",
            ),

            Divider(
                thickness: 0.25,
                color: customColors.dividerColor,
            ),

            Text(
              "Links",
              style: TextStyle(color: customColors.progressBarForeground),
            ),
            TextButton(
              onPressed: () => _openGithubSourceCode(),
              style:
                  TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
              child: const Text("Source code on Github"),
            ),

            Divider(
                thickness: 0.25,
                color: customColors.dividerColor,
            ),

            Text(
              "Developers",
              style: TextStyle(color: customColors.progressBarForeground),
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
