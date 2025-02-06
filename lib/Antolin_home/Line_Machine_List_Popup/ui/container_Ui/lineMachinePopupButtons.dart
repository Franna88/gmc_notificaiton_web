import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class LineMachinePopupButtons extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  const LineMachinePopupButtons(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: GmcColors().antolinBlack),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: GmcColors().antolinYellow,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
