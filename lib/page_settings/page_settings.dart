import 'package:flutter/material.dart';

import 'package:habit_tracker/page_settings/interface/toggle_with_short_press.dart';
import 'package:habit_tracker/page_settings/interface/extend_day_a_few_hours_past_midnight.dart';
import 'package:habit_tracker/page_settings/interface/enable_skip_days.dart';
import 'package:habit_tracker/page_settings/interface/show_question_marks_for_missing_data.dart';
import 'package:habit_tracker/page_settings/interface/use_pure_black_in_dark_theme.dart';
import 'package:habit_tracker/page_settings/interface/first_day_of_the_week.dart';

import 'package:habit_tracker/page_settings/reminder/make_notifcations_sticky.dart';
import 'package:habit_tracker/page_settings/reminder/customize_notifcations.dart';

import 'package:habit_tracker/page_settings/database/export_full_backup.dart';
import 'package:habit_tracker/page_settings/database/export_as_csv.dart';
import 'package:habit_tracker/page_settings/database/import_data.dart';

import 'package:habit_tracker/page_settings/troubleshooting/generate_bug_report.dart';

import 'package:habit_tracker/page_settings/links/help_and_faq.dart';
import 'package:habit_tracker/page_settings/links/about.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({
    super.key,
  });

  @override
  State<PageSettings> createState() => _PageSettings();
}

class _PageSettings extends State<PageSettings> {
  bool light = true;

  final heightSpacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          // width: MediaQuery.of(context).size.width * 0.9,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // interface options
              const Text(
                "Interface",
                style: TextStyle(fontSize: 20.0, color: Colors.cyan),
              ),

              SizedBox(
                height: heightSpacing,
              ),

              const ToggleWithShortPress(),

              SizedBox(
                height: heightSpacing,
              ),

              const ExtendDayAFewHoursPastMidnight(),

              SizedBox(
                height: heightSpacing,
              ),

              const EnableSkipDays(),

              SizedBox(
                height: heightSpacing,
              ),

              const ShowQuestionMarksForMissingData(),

              SizedBox(
                height: heightSpacing,
              ),

              const UsePureBlackInDarkTheme(),

              // SizedBox(
              //   height: height_spacing,
              // ),
              //
              // const Widget Opacity what is this option even for?(),

              SizedBox(
                height: heightSpacing,
              ),

              const FirstDayOfTheWeek(),

              SizedBox(
                height: heightSpacing,
              ),

              // reminder options
              const Text(
                "Reminder",
                style: TextStyle(fontSize: 20.0, color: Colors.cyan),
              ),

              SizedBox(
                height: heightSpacing,
              ),

              const MakeNotifcationsSticky(),

              SizedBox(
                height: heightSpacing,
              ),

              const CustomizeNotifcations(),

              SizedBox(
                height: heightSpacing,
              ),

              // Databse options
              const Text(
                "Database",
                style: TextStyle(fontSize: 20.0, color: Colors.cyan),
              ),

              SizedBox(
                height: heightSpacing,
              ),

              const ExportFullBackup(),

              SizedBox(
                height: heightSpacing,
              ),

              const ExportAsCSV(),

              SizedBox(
                height: heightSpacing,
              ),

              const ImportData(),

              SizedBox(
                height: heightSpacing,
              ),

              // Databse options
              const Text(
                "Troubleshooting",
                style: TextStyle(fontSize: 20.0, color: Colors.cyan),
              ),

              SizedBox(
                height: heightSpacing,
              ),

              const GenerateBugReport(),

              SizedBox(
                height: heightSpacing,
              ),

              // Databse options
              const Text(
                "Links",
                style: TextStyle(fontSize: 20.0, color: Colors.cyan),
              ),

              SizedBox(
                height: heightSpacing,
              ),

              const HelpAndFAQ(),

              SizedBox(
                height: heightSpacing,
              ),

              const About(),
            ],
          ),
        ),
      ),
    );
  }
}
