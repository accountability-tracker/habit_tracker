import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({
      super.key,
      required this.habit_name,
      required this.full_units,
      required this.current_units,
      required this.uom,
  });

  final String habit_name;
  final int full_units;
  final int current_units;
  final String uom;

  @override
  _ProgressBar createState() => _ProgressBar();
}

class _ProgressBar extends ConsumerState<ProgressBar> {
  String progress = '';
  @override
  void initState() {
    super.initState();
    String habit_name = widget.habit_name;
    this.progress = '${widget.current_units} / ${widget.full_units} ${widget.uom}';
    // ref.read(habitsManagerProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: [Text(widget.habit_name)],),
              Column(children: [Text(this.progress,style: TextStyle(color: Colors.grey),)],),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.black,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            value: widget.current_units/widget.full_units,
          ),
        ],
      ),
    );
  }
}