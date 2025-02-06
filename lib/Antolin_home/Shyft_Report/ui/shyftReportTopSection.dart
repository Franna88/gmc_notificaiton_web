import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/gmcColors.dart';
import '../../../Constants/myutility.dart';

class ShyftReportTopSection extends StatelessWidget {
  final bool isRunning;
  final String shiftNumber;
  final String oee;
  final String operatorName;
  final String workOrder;
  const ShyftReportTopSection(
      {super.key,
      required this.isRunning,
      required this.shiftNumber,
      required this.oee,
      required this.operatorName,
      required this.workOrder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MyUtility(context).width,
      color: GmcColors().antolinBlack,
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          Text(
            'Status :',
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            isRunning == true ? 'RUNNING' : 'PAUSED',
            style: GoogleFonts.inter(
              color:
                  isRunning == true ? Colors.green : GmcColors().antolinOrange,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Shift :',
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            shiftNumber,
            style: GoogleFonts.inter(
              color: GmcColors().antolinOrange,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'OEE :',
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            oee,
            style: GoogleFonts.inter(
              color: GmcColors().antolinOrange,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Operator :',
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            operatorName,
            style: GoogleFonts.inter(
              color: GmcColors().antolinOrange,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Work Order :',
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            workOrder,
            style: GoogleFonts.inter(
              color: GmcColors().antolinOrange,
            ),
          ),
        ],
      ),
    );
  }
}
