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
import 'package:habit_tracker/page_about/page_about.dart';

class Page_Settings extends StatefulWidget {
  const Page_Settings({
      super.key,
  });

  @override
  _Page_Settings createState() => _Page_Settings();
}

class _Page_Settings extends State<Page_Settings> {

  bool light = true;

  var height_spacing = 16.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
      ),
      body: SingleChildScrollView(

        child: Container(
          margin: EdgeInsets.all(16.0),
          // width: MediaQuery.of(context).size.width * 0.9,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // interface options
              const Text(
                "Interface",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan
                ),
              ),

              SizedBox(
                height: height_spacing,
              ),

              const ToggleWithShortPress(),

              SizedBox(
                height: height_spacing,
              ),

              const ExtendDayAFewHoursPastMidnight(),

              SizedBox(
                height: height_spacing,
              ),

              const EnableSkipDays(),

              SizedBox(
                height: height_spacing,
              ),

              const ShowQuestionMarksForMissingData(),

              SizedBox(
                height: height_spacing,
              ),

              const UsePureBlackInDarkTheme(),

              // SizedBox(
              //   height: height_spacing,
              // ),
              //
              // const Widget Opacity what is this option even for?(),

              SizedBox(
                height: height_spacing,
              ),

              const FirstDayOfTheWeek(),

              SizedBox(
                height: height_spacing,
              ),

              // reminder options
              const Text(
                "Reminder",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan
                ),
              ),

              SizedBox(
                height: height_spacing,
              ),

              const MakeNotifcationsSticky(),

              SizedBox(
                height: height_spacing,
              ),

              const CustomizeNotifcations(),

              SizedBox(
                height: height_spacing,
              ),

              // Databse options
              const Text(
                "Database",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan
                ),
              ),

              SizedBox(
                height: height_spacing,
              ),

              const ExportFullBackup(),

              SizedBox(
                height: height_spacing,
              ),

              const ExportAsCSV(),

              SizedBox(
                height: height_spacing,
              ),

              const ImportData(),

              SizedBox(
                height: height_spacing,
              ),

              // Databse options
              const Text(
                "Troubleshooting",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan
                ),
              ),

              SizedBox(
                height: height_spacing,
              ),

              const GenerateBugReport(),

              SizedBox(
                height: height_spacing,
              ),

              // Databse options
              const Text(
                "Links",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan
                ),
              ),

              SizedBox(
                height: height_spacing,
              ),

              const HelpAndFAQ(),

              SizedBox(
                height: height_spacing,
              ),

              const About(),

            ],
          ),
        ),
      ),
    );
  }
}
