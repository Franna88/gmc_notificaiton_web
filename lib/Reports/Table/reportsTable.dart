import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/timerContainer.dart';
import 'package:gmcweb/Users/UserTable/ui/tableStructure.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsTable extends StatefulWidget {
  const ReportsTable({super.key});

  @override
  State<ReportsTable> createState() => _ReportsTableState();
}

class _ReportsTableState extends State<ReportsTable> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> reports = [
      {
        'lineID': 'AG5J53N',
        'date': '02 DEC 2024',
        'technician': 'James Harmse'
      },
      {
        'lineID': 'AG5J53N',
        'date': '02 DEC 2024',
        'technician': 'James Harmse'
      },
      {'lineID': 'AG5J53N', 'date': '02 DEC 2024', 'technician': 'James Harmse'}
    ];

    return Container(
      height: MyUtility(context).height - 205,
      width: MyUtility(context).width - 340,
      decoration: BoxDecoration(
          border: Border.all(color: GmcColors().black),
          color: GmcColors().lightGrey),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: GmcColors().black,
            ),
            children: [
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Line ID',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Date',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Technician',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Cause',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Resolved',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              TableStructure(
                child: TableCell(
                  child: Text(
                    'Downtime',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(
            reports.length,
            (index) {
              final user = reports[index];
              return TableRow(
                decoration: BoxDecoration(
                  color: index % 2 == 1
                      ? Colors.white
                      : Color.fromRGBO(209, 210, 146, 0),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: GmcColors().black,
                    ),
                  ),
                ),
                children: [
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['lineID']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['date']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: Text(
                        user['technician']!,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: SmallButtons(
                        onTap: () {},
                        buttonText: 'View',
                        buttonColor: GmcColors().teal,
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: SmallButtons(
                        onTap: () {},
                        buttonText: 'View',
                        buttonColor: GmcColors().orange,
                      ),
                    ),
                  ),
                  TableStructure(
                    child: TableCell(
                      child: TimerContainer(isOffline: true)
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
