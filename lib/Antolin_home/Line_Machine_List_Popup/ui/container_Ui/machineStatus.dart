import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

class MachineStatus extends StatelessWidget {
  final bool isOnline;
  const MachineStatus({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 80,
      decoration: BoxDecoration(
        color: GmcColors().antolinBlack,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          isOnline == true ? 'Online' : 'Offline',
          style: GoogleFonts.inter(
              color: isOnline == true ? Colors.green : GmcColors().red,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
