import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/gmcColors.dart';

class PopupLineHeader extends StatelessWidget {
  final String line;
  final String operation;
  const PopupLineHeader({super.key, required this.line, required this.operation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 525,
      color: GmcColors().antolinBlack,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              line,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              operation,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
