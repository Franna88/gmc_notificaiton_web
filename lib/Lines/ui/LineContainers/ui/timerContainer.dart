import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerContainer extends StatefulWidget {
  final bool isOffline;
  const TimerContainer({super.key, required this.isOffline});

  @override
  State<TimerContainer> createState() => _TimerContainerState();
}

class _TimerContainerState extends State<TimerContainer> {
  Timer? _timer; // Make _timer nullable
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isOffline) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant TimerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOffline && !oldWidget.isOffline) {
      _startTimer();
    } else if (!widget.isOffline && oldWidget.isOffline) {
      _stopTimer();
    }
  }

  void _startTimer() {
    _stopTimer(); // Ensure no duplicate timers are running
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null; // Set to null to avoid reuse
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        _formatTime(_secondsElapsed),
        style:  GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
