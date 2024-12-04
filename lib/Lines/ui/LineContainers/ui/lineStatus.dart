import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineStatus extends StatefulWidget {
  final bool isOffline;
  const LineStatus({super.key, required this.isOffline});

  @override
  State<LineStatus> createState() => _LineStatusState();
}

class _LineStatusState extends State<LineStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        color: widget.isOffline
              ? Color.fromRGBO(252, 0, 0, 0.25)
              : Color.fromRGBO(0, 137, 0, 0.25),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 1.5,
          color: widget.isOffline
              ? Color.fromRGBO(252, 0, 0, 1)
              : Color.fromRGBO(0, 137, 0, 1),
        ),
      ),
      child: Center(
        child: Text(
          widget.isOffline ? 'Offline' : 'Online',
          style: GoogleFonts.roboto(
            color: widget.isOffline
                ? Color.fromRGBO(252, 0, 0, 1)
                : Color.fromRGBO(0, 137, 0, 1),
                fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
