import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/components/flat_date_picker.dart';
import 'package:habit_tracker/components/flat_number_inc.dart';
import 'package:habit_tracker/components/color_select.dart';
import 'package:habit_tracker/components/flat_switch.dart';

import 'package:habit_tracker/s_isar.dart';
import 'package:habit_tracker/entities/habit.dart';
import 'package:habit_tracker/habit_enums.dart';

import 'package:habit_tracker/habits.dart';

import 'package:habit_tracker/components/flat_textfield.dart';
import 'package:habit_tracker/components/flat_dropdown.dart';

import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/theme.dart';

// TODO(clearfeld): move this into its own file and make it an enum instead
const List<String> frequencyList = <String>[
  'Per Day',
  'Per Week',
  'Bi-weekly',
  'Per Month',
  'Every # Days'
];

// TODO(clearfeld): expend this into its own class
const List<String> reminderList = <String>['Off', 'On'];

class PageCreateNewHabitYesOrNo extends ConsumerStatefulWidget {
  const PageCreateNewHabitYesOrNo({
    super.key,
    required this.isarService,
    this.fHabit,
  });

  final IsarService isarService;
  final Habit? fHabit;

  @override
  ConsumerState<PageCreateNewHabitYesOrNo> createState() => _PageCreateNewHabitYesOrNo();
  // State<Page_CreateNewHabitYesOrNo> createState() => _Page_CreateNewHabitYesOrNo();
}

class _PageCreateNewHabitYesOrNo extends ConsumerState<PageCreateNewHabitYesOrNo> {
  final nameTextController = TextEditingController();
  final questionTextController = TextEditingController();
  String frequencyValue = frequencyList.first;

  String reminderValue = reminderList.first;
  final reminderOn = TextEditingController();
  final notesTextController = TextEditingController();
  final reminderTextController = TextEditingController();
  final currentColor = TextEditingController();
  final customColor = TextEditingController();

  final frequencyAmountController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(habitsManagerProvider);

    if (widget.fHabit != null) {
      nameTextController.text = widget.fHabit?.getTitle() ?? "";
      questionTextController.text = widget.fHabit?.getQuestion() ?? "";
      frequencyAmountController.text = widget.fHabit?.getFrequencyAmount().toString() ?? "1";
      if (widget.fHabit?.getReminderTime() != null) {
        dateController.text = widget.fHabit?.getReminderTime() ?? "12:00";
        reminderTextController.text = widget.fHabit?.getReminderMessage() ?? "";
        reminderOn.text = 't';
      }
      else {
        dateController.text = "12:00";
        reminderTextController.text = "";
      }
      customColor.text = '0xff443a49';
      currentColor.text = widget.fHabit?.getColorString() ?? '0xfff16567';

      if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.everyDay) {
        frequencyValue = 'Per Day';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerWeek) {
        frequencyValue = 'Per Week';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.xTimesPerMonth) {
        frequencyValue = 'Per Month';
      } else if (widget.fHabit?.getFrequency() == EHABITFREQUENCY.everyXDays) {
        frequencyValue = 'Every # Days';
      }
      // // String frequencyValue = frequencyList.first;

      // // String reminderValue = reminderList.first;
      notesTextController.text = widget.fHabit?.getNotes() ?? "";

      if (widget.fHabit?.getColorString() != '0xfff16567' &&
          widget.fHabit?.getColorString() != '0xff2ec977' &&
          widget.fHabit?.getColorString() != '0xff5666f3' &&
          widget.fHabit?.getColorString() != '0xfff7f186' &&
          widget.fHabit?.getColorString() != '0xff9186f4') {
        customColor.text = widget.fHabit?.getColorString() ?? '0xff443a49';
      }
    } else {
      frequencyAmountController.text = "1";
      dateController.text = "12:00";
      customColor.text = '0xff443a49';
      currentColor.text = '0xfff16567';
    }
  }

  @override
  void dispose() {
    nameTextController.dispose();
    questionTextController.dispose();
    notesTextController.dispose();
    frequencyAmountController.dispose();
    super.dispose();
  }

  void addHabit() {
    var freq = EHABITFREQUENCY.everyDay;
    if (frequencyValue == 'Per Day') {
      freq = EHABITFREQUENCY.everyDay;
    } else if (frequencyValue == 'Per Week') {
      freq = EHABITFREQUENCY.xTimesPerWeek;
    } else if (frequencyValue == 'Per Month') {
      freq = EHABITFREQUENCY.xTimesPerMonth;
    } else if (frequencyValue == 'Every # Days') {
      freq = EHABITFREQUENCY.everyXDays;
    }

    if (widget.fHabit != null) {
      var h = widget.fHabit;
      var c = currentColor.text;
      var reminderText;
      var reminderTime;
      if (reminderOn.text == 't') {
        reminderText = reminderTextController.text;
        reminderTime = dateController.text;
      }

      h?.title = nameTextController.text;
      h?.question = questionTextController.text;
      h?.notes = notesTextController.text;
      h?.color = c;
      h?.frequency = freq;
      h?.frequencyAmount = int.parse(frequencyAmountController.text);
      h?.reminderMessage = reminderText;
      h?.reminderTime = reminderTime;

      widget.isarService.updateHabit(h);
    } else {
      var c = currentColor.text;
      var reminderText;
      var reminderTime;
      if (reminderOn.text == 't') {
        reminderText = reminderTextController.text;
        reminderTime = dateController.text;
      }

      widget.isarService.saveHabit(Habit.full(
          EHABITS.yesOrNo,
          nameTextController.text,
          c,
          freq,
          int.parse(frequencyAmountController.text),
          reminderTime,
          reminderText,
          questionTextController.text,
          notesTextController.text));
    }

    ref.watch(habitsManagerProvider.notifier).addHabit(HabitYesOrNo(
        // TODO(clearfeld): pull id from isar or whatever the persistance ends up being
        -1,
        EHABITS.yesOrNo,
        nameTextController.text,
        Color(int.parse(currentColor.text)),
        questionTextController.text,
        notesTextController.text));

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text(
    //         nameTextController.text + " " +
    //         questionTextController.text + " " +
    //         frequencyValue + " " +
    //         reminderValue + " " +
    //         notesTextController.text + " " +
    //         currentColor.toString()
    //       )
    //     );
    //   },
    // );
  }

  void leavePage(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: customColors.background,
      appBar: AppBar(
        title: Text(widget.fHabit?.getTitle() ?? "New Habit", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: customColors.navbarBackground,
        surfaceTintColor: Colors.transparent,
        shadowColor: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(children: [
            InkWell(
              child: Text("Save", style: TextStyle(color: customColors.textColorLink)),
              onTap: () {
                if (nameTextController.text == '') {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: customColors.background,
                          surfaceTintColor: customColors.background,
                          title: const Text('Please enter a valid title.'),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('Okay', style: TextStyle(color: customColors.textColorLink)),
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(customColors.backgroundCompliment)),
                              onPressed: () {
                                // setState(() => currentValue = initialValue);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  addHabit();
                  ref.read(dataUpdate.notifier).setUpdate();
                  leavePage(context);
                }
              }
            ),
            SizedBox(width: 10,)
          ],)
        ],
        leading: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Text("Cancel", style: TextStyle(color: customColors.textColorSecondary),),
                onTap: () {Navigator.of(context).pop();}
              )
            )
          ]
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            constraints: const BoxConstraints(
              minWidth: 320,
              maxWidth: 896, // 16 * 56
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const Text(
                //   'Create your new habit',
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatTextField(
                      textController: nameTextController,
                      hintText: "Title",
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ColorSelect(currentColor: currentColor, customColor: customColor,),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Question", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: questionTextController,
                      hintText: "e.g. Did you exercise today?",
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Row(
                  children: const [
                    Text("Frequency", style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 16.0,
                        ),
                        FlatNumIncField(
                          textController: frequencyAmountController,
                        ),
                      ]
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(""),
                          FlatDropdown(
                            value: frequencyValue,
                            onValueChanged: (String? valueArg) {
                              setState(() {
                                frequencyValue = valueArg!;
                              });
                            },
                            items: frequencyList,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text("Reminder", style: TextStyle(fontWeight: FontWeight.bold),),
                        Expanded(child: SizedBox()),
                        FlatSwitch(reminderController: reminderOn,),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        FlatDatePicker(dateController: dateController,),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: FlatTextField(
                            textController: reminderTextController,
                            hintText: "Reminder Message",
                          ),
                        )
                      ],
                    )
                  ],
                ),

                const SizedBox(
                  height: 16.0,
                ),
                Divider(color: customColors.backgroundCompliment, thickness: 1,),
                const SizedBox(
                  height: 16.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 8.0,
                    ),
                    FlatTextField(
                      textController: notesTextController,
                      hintText: "(Optional)",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
