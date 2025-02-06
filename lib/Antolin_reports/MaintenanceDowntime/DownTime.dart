import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// **Page 1: Report DownTime**
class ReportDownTime extends StatefulWidget {
  const ReportDownTime({super.key});

  @override
  State<ReportDownTime> createState() => _ReportDownTimeState();
}

class _ReportDownTimeState extends State<ReportDownTime> {
  final List<DownTimeRecords> _records = [
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Line 1',
      type: 'Maintenance',
      section: 'OP 30.1 1600 Press',
      shift: 1,
      assignedStaff: 'Ammar Foulie',
      downtime: '12:35',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Line 2',
      type: 'Breakdown',
      section: 'OP 101 1200 Ton Press',
      shift: 2,
      assignedStaff: 'James Myers',
      downtime: '03:00',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Line 3',
      type: 'Breakdown',
      section: 'OP 50 Water jet cutting',
      shift: 2,
      assignedStaff: 'Anton Mars',
      downtime: '25:34',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Line 4',
      type: 'Maintenance',
      section: 'OP 60.2 Assembly',
      shift: 1,
      assignedStaff: 'Tomas Koor',
      downtime: '17:12',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Line 4',
      type: 'Maintenance',
      section: 'OP 90 VW 270 HL/LL',
      shift: 1,
      assignedStaff: 'Ammar Foulie',
      downtime: '56:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DownTimeTable(records: _records),
      ),
    );
  }
}

/// **Data Model**
class DownTimeRecords {
  final String date;
  final String line;
  final String type;
  final String section;
  final int shift;
  final String assignedStaff;
  final String downtime;

  DownTimeRecords({
    required this.date,
    required this.line,
    required this.type,
    required this.section,
    required this.shift,
    required this.assignedStaff,
    required this.downtime,
  });
}

/// **Page 2: Production Table**
class DownTimeTable extends StatelessWidget {
  final List<DownTimeRecords> records;

  const DownTimeTable({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// **Table Header**
        Container(
          color: const Color(0xFF3D3B3C),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: const [
              Expanded(flex: 2, child: TableHeaderText('Date')),
              Expanded(flex: 2, child: TableHeaderText('Line')),
              Expanded(flex: 2, child: TableHeaderText('Type')),
              Expanded(flex: 2, child: TableHeaderText('Section')),
              Expanded(flex: 1, child: TableHeaderText('Shift')),
              Expanded(flex: 2, child: TableHeaderText('Assigned Staff')),
              Expanded(flex: 1, child: TableHeaderText('Downtime')),
              Expanded(flex: 1, child: TableHeaderText('Details')),
            ],
          ),
        ),

        /// **Table Rows**
        Expanded(
          child: ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              final isEvenRow = index.isEven;

              return Container(
                color: isEvenRow ? Colors.white : const Color(0xFFD9D9D9),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: TableText(record.date)),
                    Expanded(flex: 2, child: TableText(record.line)),
                    Expanded(flex: 2, child: TableText(record.type)),
                    Expanded(flex: 2, child: TableText(record.section)),
                    Expanded(
                        flex: 1, child: TableText(record.shift.toString())),
                    Expanded(flex: 2, child: TableText(record.assignedStaff)),
                    Expanded(flex: 1, child: FixedSizeCell(record.downtime)),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'View',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TableHeaderText extends StatelessWidget {
  final String text;
  const TableHeaderText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TableText extends StatelessWidget {
  final String text;
  const TableText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FixedSizeCell extends StatelessWidget {
  final String text;
  const FixedSizeCell(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 35,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
