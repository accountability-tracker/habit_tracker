import 'package:flutter/material.dart';

import "./Interface/ToggleWithShortPress.dart";
import "./Interface/ExtendDayAFewHoursPastMidnight.dart";
import "./Interface/EnableSkipDays.dart";
import "./Interface/ShowQuestionMarksForMissingData.dart";
import "./Interface/UsePureBlackInDarkTheme.dart";
import "./Interface/FirstDayOfTheWeek.dart";

import "./Reminder/MakeNotifcationsSticky.dart";
import "./Reminder/CustomizeNotifcations.dart";

import "./Database/ExportFullBackup.dart";
import "./Database/ExportAsCSV.dart";
import "./Database/ImportData.dart";

import "./Troubleshooting/GenerateBugReport.dart";

import "./Links/HelpAndFAQ.dart";
import 'package:habit_tracker/page_about/page_about.dart';
import 'package:habit_tracker/SettingsPage/Links/About.dart';

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
