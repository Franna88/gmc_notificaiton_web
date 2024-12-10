import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class TimerContainer extends StatefulWidget {
//   final DateTime? startTime; // Pass startTime from Firestore
//   final bool isOffline; // Pass status from Firestore

//   const TimerContainer({
//     super.key,
//     required this.startTime,
//     required this.isOffline,
//   });

//   @override
//   State<TimerContainer> createState() => _TimerContainerState();
// }

// class _TimerContainerState extends State<TimerContainer> {
//   Timer? _timer;
//   int _elapsedSeconds = 0;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isOffline && widget.startTime != null) {
//       _startTimer();
//     }
//   }

//   @override
//   void didUpdateWidget(covariant TimerContainer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.isOffline && widget.startTime != null) {
//       _startTimer();
//     } else {
//       _stopTimer();
//     }
//   }

//   void _startTimer() {
//     _stopTimer(); // Ensure no duplicate timers
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (widget.startTime != null) {
//         final now = DateTime.now();
//         setState(() {
//           _elapsedSeconds = now.difference(widget.startTime!).inSeconds;
//         });
//       }
//     });
//   }

//   void _stopTimer() {
//     if (_timer != null && _timer!.isActive) {
//       _timer!.cancel();
//       _timer = null;
//     }
//   }

//   @override
//   void dispose() {
//     _stopTimer();
//     super.dispose();
//   }

//   String _formatTime(int seconds) {
//     final minutes = seconds ~/ 60;
//     final remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 30,
//       width: 100,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         widget.isOffline ? _formatTime(_elapsedSeconds) : 'Online',
//         style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

class TimerContainer extends StatefulWidget {
  final DateTime? startTime;
  final bool isOffline;
  final String lineID;

  const TimerContainer({
    super.key,
    required this.startTime,
    required this.isOffline,
    required this.lineID,
  });

  @override
  State<TimerContainer> createState() => _TimerContainerState();
}

class _TimerContainerState extends State<TimerContainer> {
  Timer? _timer;
  int _elapsedSeconds = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isOffline && widget.startTime != null) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant TimerContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOffline && widget.startTime != null) {
      _startTimer();
    } else if (!widget.isOffline) {
      _stopTimer();
      _updateDownedLines(); // Update Firestore when online
    }
  }

  void _startTimer() {
    _stopTimer(); // Ensure no duplicate timers
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (widget.startTime != null) {
        final now = DateTime.now();
        setState(() {
          _elapsedSeconds = now.difference(widget.startTime!).inSeconds;
        });
      }
    });
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  Future<void> _updateDownedLines() async {
    try {
      final totalTime = _elapsedSeconds;
      await FirebaseFirestore.instance
          .collection('downedLines')
          .doc(widget.lineID)
          .update({
        'totalTime': FieldValue.increment(totalTime),
      });

      // Reset elapsed time after updating
      setState(() {
        _elapsedSeconds = 0;
      });

      print('Updated downedLines with total time: $totalTime');
    } catch (e) {
      print('Error updating downedLines: $e');
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
        widget.isOffline ? _formatTime(_elapsedSeconds) : 'Online',
        style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
