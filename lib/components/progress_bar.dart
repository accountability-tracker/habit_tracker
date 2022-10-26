import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({
      super.key,
      required this.habitName,
      required this.fullUnits,
      required this.currentUnits,
      required this.uom,
  });

  final String habitName;
  final int fullUnits;
  final int currentUnits;
  final String uom;

  @override
  _ProgressBar createState() => _ProgressBar();
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(widget.habitName)
                ],
              ),

              Column(
                children: [
                  Text(
                    progress,
                    style: const TextStyle(
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 10.0,
          ),

          LinearProgressIndicator(
            backgroundColor: Colors.black,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: widget.currentUnits / widget.fullUnits,
          ),
        ],
      ),
    );
  }
}