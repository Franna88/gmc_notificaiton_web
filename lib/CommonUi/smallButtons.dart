import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallButtons extends StatefulWidget {
  final Function() onTap;
  final String buttonText;
  final Color buttonColor;
  const SmallButtons(
      {super.key,
      required this.onTap,
      required this.buttonText,
      required this.buttonColor});

  @override
  State<SmallButtons> createState() => _SmallButtonsState();
}

class _SmallButtonsState extends State<SmallButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 120,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: widget.buttonColor),
        child: Center(
          child: Text(
            widget.buttonText,
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
