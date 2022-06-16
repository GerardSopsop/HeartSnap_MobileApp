import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar(
      {Key? key,
      required this.current,
      required this.total,
      required this.text})
      : super(key: key);
  final double current, total;
  final String text;
  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 60;
    double current = widget.current;
    if (current < 0) {
      current = 0;
    }
    final double progress = current / widget.total;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: (width - 20) / 1.5,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      fontFamily: "DMSans", color: Colors.white, fontSize: 12),
                ),
              ),
              SizedBox(
                width: (width - 20) / 3,
                child: Text(
                  "${widget.current}/${widget.total}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontFamily: "DMSans", color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 2)),
          LinearPercentIndicator(
              width: width,
              animation: true,
              lineHeight: 5.0,
              animationDuration: 1000,
              percent: current > widget.total ? 1 : progress,
              barRadius: const Radius.circular(2),
              progressColor: progress > 1
                  ? const Color.fromARGB(255, 220, 91, 111)
                  : Colors.lightGreen,
              backgroundColor: Colors.grey),
          const Padding(padding: EdgeInsets.only(bottom: 15)),
        ],
      ),
    );
  }
}
