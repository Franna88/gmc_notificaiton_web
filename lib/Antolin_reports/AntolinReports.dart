import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_reports/Productions/ProductionReports.dart';

class AntolinReports extends StatefulWidget {
  const AntolinReports({super.key});

  @override
  State<AntolinReports> createState() => _AntolinReportsState();
}

class _AntolinReportsState extends State<AntolinReports> {
  final List<ProductionRecord> _records = [
    ProductionRecord(
      productType: 'Roof Lining',
      batchNumber: 'WP 5395',
      orderQty: 25000,
      shift: 1,
      assignedStaff: 'Ammar Foulie',
      totalOut: 25000,
      waste: 55,
      downtime: '12:35',
    ),
    ProductionRecord(
      productType: 'Roof Lining',
      batchNumber: 'WP 8855',
      orderQty: 3000,
      shift: 1,
      assignedStaff: 'James Myers',
      totalOut: 3000,
      waste: 3,
      downtime: '03:00',
    ),
    ProductionRecord(
      productType: 'Side Panels',
      batchNumber: 'RR 4624',
      orderQty: 1500,
      shift: 2,
      assignedStaff: 'Anton Mars',
      totalOut: 1500,
      waste: 103,
      downtime: '03:40',
    ),
    ProductionRecord(
      productType: 'Side Panels',
      batchNumber: 'RR 7743',
      orderQty: 2500,
      shift: 2,
      assignedStaff: 'Tomas Koor',
      totalOut: 2500,
      waste: 337,
      downtime: '06:17',
    ),
    ProductionRecord(
      productType: 'Roof Lining',
      batchNumber: 'WP 8864',
      orderQty: 800,
      shift: 2,
      assignedStaff: 'Ammar Foulie',
      totalOut: 800,
      waste: 18,
      downtime: '01:37',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ProductionTable(records: _records), // Connect table here
    );
  }
}
