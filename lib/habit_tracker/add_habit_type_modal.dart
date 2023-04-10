import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import 'package:habit_tracker/theme.dart';
// import 'package:habit_tracker/data_notifier.dart';
import 'package:habit_tracker/s_isar.dart';

import 'package:habit_tracker/page_create_new_habit_yes_or_no/page_create_new_habit_yes_or_no.dart';
import 'package:habit_tracker/page_create_new_habit_measurable/page_create_new_habit_measurable.dart';

class AddHabitTypeModal extends ConsumerStatefulWidget {
  const AddHabitTypeModal({
    super.key,
    required this.isarService,
    required this.refreshHabitList,
  });

  final IsarService isarService;
  final Function(dynamic) refreshHabitList;

  @override
  ConsumerState<AddHabitTypeModal> createState() => _AddHabitTypeModal();
}

class _AddHabitTypeModal extends ConsumerState<AddHabitTypeModal> {
  bool isHoverYesOrNo = false;
  bool isHoverMesurable = false;
  bool isHoverCancel = false;

  @override
  Widget build(BuildContext context) {
    // final customColors = Theme.of(context).extension<CustomColors>()!;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.6,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF18171E),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: <Widget>[
            const Spacer(),
            const Text(
              "Select Habit Type",
              style: TextStyle(
                fontSize: 40.0,
                // fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: !isHoverYesOrNo ? const Color(0xff242430) : const Color(0xff0B0B0F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1,
                          Animation<double> animation2) {
                        return PageCreateNewHabitYesOrNo(isarService: widget.isarService);
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ).then(widget.refreshHabitList);
                },
                onHover: (val) {
                  setState(() {
                    isHoverYesOrNo = val;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const <Widget>[
                      Text(
                        "Yes or No",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "e.g. Did you wake up early today? Did you exercise? Did you play chess?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: !isHoverMesurable ? const Color(0xff242430) : const Color(0xff0B0B0F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1,
                          Animation<double> animation2) {
                        return PageCreateNewHabitMeasurable(isarService: widget.isarService);
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ).then(widget.refreshHabitList);
                },
                onHover: (val) {
                  setState(() {
                    isHoverMesurable = val;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const <Widget>[
                      Text(
                        "Measurable",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "e.g. How many miles did you run today? How many pages did you read?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: !isHoverCancel ? const Color(0xff242430) : const Color(0xff0B0B0F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                onHover: (val) {
                  setState(() {
                    isHoverCancel = val;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(48.0, 16.0, 48.0, 16.0),
                  child: Column(
                    children: const <Widget>[
                      Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
