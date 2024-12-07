import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';

class ReportsTable extends StatefulWidget {
  const ReportsTable({super.key});

  @override
  State<ReportsTable> createState() => _ReportsTableState();
}

class _ReportsTableState extends State<ReportsTable> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      final querySnapshot = await _firestore.collection('downedLines').get();
      final fetchedReports = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'lineID': data['lineId'],
          'date': (data['timestamp'] as Timestamp).toDate().toString(),
          'technician': data['technicianName'],
          'cause': data['cause'],
          'resolution': data['resolution'],
          'status': data['status'],
          'lineName': data['lineName'],
        };
      }).toList();

      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void showCausePopup(BuildContext context, Map<String, dynamic> causeData) {
    // Define this function to show the cause popup
  }

  void showResolvePopup(
      BuildContext context, Map<String, dynamic> resolutionData) {
    // Define this function to show the resolve popup
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      'Line ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Technician',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Cause',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Resolved',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Downtime',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: reports.map((report) {
                  return DataRow(
                    cells: [
                      DataCell(Text(report['lineID'] ?? '')),
                      DataCell(Text(report['date'] ?? '')),
                      DataCell(Text(report['technician'] ?? 'No Name')),
                      DataCell(
                        SmallButtons(
                          onTap: () {
                            showCausePopup(context, report['cause'][0]);
                          },
                          buttonText: 'View',
                          buttonColor: GmcColors().teal,
                        ),
                      ),
                      DataCell(
                        SmallButtons(
                          onTap: () {
                            showResolvePopup(context, report['resolution'][0]);
                          },
                          buttonText: 'View',
                          buttonColor: GmcColors().orange,
                        ),
                      ),
                      DataCell(Text('00:00')), // Replace with actual downtime
                    ],
                  );
                }).toList(),
              ),
            ),
          );
  }
}
