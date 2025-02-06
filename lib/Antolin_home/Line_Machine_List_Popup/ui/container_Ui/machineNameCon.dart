import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/gmcColors.dart';

class MachineNameCon extends StatelessWidget {
  final String machineName;
  const MachineNameCon({super.key, required this.machineName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 180,
      decoration: BoxDecoration(color: GmcColors().antolinBlack),
      child: Center(
        child: Text(
          machineName,
          style: GoogleFonts.inter(
              color: GmcColors().antolinYellow, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
