import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_reports/AntolinReports.dart';
import 'package:gmcweb/Antolin_reports/FilterRow.dart/FilterRow.dart';
import 'package:gmcweb/Antolin_reports/MaintenanceDowntime/DownTime.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class AntolinReportsMain extends StatefulWidget {
  const AntolinReportsMain({super.key});

  @override
  State<AntolinReportsMain> createState() => _AntolinReportsMainState();
}

class _AntolinReportsMainState extends State<AntolinReportsMain> {
  bool isSidePanelsSelected = true; // Default selected button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: GmcColors().antolinBlack, width: 3),
          ),
        ),
        height: MyUtility(context).height,
        width: MyUtility(context).width,
        child: Column(
          children: [
            Container(
              height: 55,
              width: MyUtility(context).width - 80,
              color: GmcColors().antolinBlack,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 3),
                    child: Row(
                      children: [
                        // Side Panels Button (Gradient when selected)
                        _buildButton(
                          text: 'PRODUCTIONS',
                          isSelected: isSidePanelsSelected,
                          onTap: () {
                            setState(() => isSidePanelsSelected = true);
                          },
                        ),

                        const SizedBox(width: 10), // Space between buttons
                        // Maintenance & Downtime Button (Gradient when selected)
                        _buildButton(
                          text: 'MAINTENANCE & DOWNTIME',
                          isSelected: !isSidePanelsSelected,
                          onTap: () {
                            setState(() => isSidePanelsSelected = false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            FilterRow(),
            const SizedBox(height: 15),
            // Conditional Page Display
            Expanded(
              child: isSidePanelsSelected
                  ? const AntolinReports()
                  : const ReportDownTime(),
            ),
          ],
        ),
      ),
    );
  }

  /// Button with dynamic gradient selection
  Widget _buildButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    GmcColors().antolinTeal,
                    const Color.fromRGBO(16, 90, 71, 1),
                  ],
                )
              : null, // No gradient when not selected
          color: isSelected
              ? null
              : Colors.white, // White background for unselected button
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: isSelected
                    ? Colors.white
                    : Colors.black, // Swap text color dynamically
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
