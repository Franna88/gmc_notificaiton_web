import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_reports/MaintenanceDowntime/DownTime.dart';
import 'package:gmcweb/Antolin_reports/SidePannels/ProductionReports.dart'; // Import the table widget

class ReportDownTime extends StatefulWidget {
  const ReportDownTime({super.key});

  @override
  State<ReportDownTime> createState() => _ReportDownTimeState();
}

class _ReportDownTimeState extends State<ReportDownTime> {
  final List<DownTimeRecords> _records = [
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Roof Lining',
      type: 'Production',
      section: 'WP 5395',
      shift: 1,
      assignedStaff: 'Ammar Foulie',
      downtime: '12:35',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Roof Lining',
      type: 'Production',
      section: 'WP 8855',
      shift: 1,
      assignedStaff: 'James Myers',
      downtime: '03:00',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Side Panels',
      type: 'Production',
      section: 'RR 4624',
      shift: 2,
      assignedStaff: 'Anton Mars',
      downtime: '03:40',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Side Panels',
      type: 'Production',
      section: 'RR 7743',
      shift: 2,
      assignedStaff: 'Tomas Koor',
      downtime: '06:17',
    ),
    DownTimeRecords(
      date: '2024-02-05',
      line: 'Roof Lining',
      type: 'Production',
      section: 'WP 8864',
      shift: 2,
      assignedStaff: 'Ammar Foulie',
      downtime: '01:37',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Production Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DownTimeTable(records: _records), // Connect table here
      ),
    );
  }
}
