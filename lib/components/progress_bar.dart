import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/theme.dart';

class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({
    super.key,
    required this.habitName,
    required this.fullUnits,
    required this.currentUnits,
    required this.uom,
    required this.color,
  });

  final String habitName;
  final int fullUnits;
  final int currentUnits;
  final String uom;
  final int color;

  @override
  ConsumerState<ProgressBar> createState() => _ProgressBar();
}

class _ProgressBar extends ConsumerState<ProgressBar> {
  String progress = '';
  @override
  void initState() {
    super.initState();
    progress = '${widget.currentUnits} / ${widget.fullUnits} ${widget.uom}';
    // ref.read(habitsManagerProvider);
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    widget.habitName,
                    style: const TextStyle(
                      fontSize: 24.0,
                      //color: Color(widget.color)
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    progress,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24.0,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          LinearProgressIndicator(
            backgroundColor: customColors.progressBarBackground,
            valueColor: AlwaysStoppedAnimation<Color>(customColors.progressBarForeground!),
            value: widget.currentUnits / widget.fullUnits,
            minHeight: 8.0,
          ),
        ],
      ),
    );
  }
}
