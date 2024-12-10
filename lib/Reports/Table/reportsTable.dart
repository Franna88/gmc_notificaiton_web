import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Reports/ReportsPopUps/cause_popup.dart';
import 'package:gmcweb/Reports/ReportsPopUps/resolve_popup.dart';

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
        final totalSeconds =
            int.tryParse(data['totalDownTime'].toString()) ?? 0;
        // Convert to minutes
        final totalMinutes = (totalSeconds / 60).ceil();
        return {
          'lineID': data['lineId'],
          'date': (data['timestamp'] as Timestamp).toDate().toString(),
          'technician': data['technicianName'],
          'cause': data['cause'],
          'resolution': data['resolution'],
          'status': data['status'],
          'lineName': data['lineName'],
          // Format with "Min"
          'totalDownTime': '$totalMinutes Min',
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

  void showCausePopup(BuildContext context, Map<String, dynamic>? causeData) {
    if (causeData == null) {
      // Handle the case where no cause data is available
      print('Cause data is null.');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CausePopup(causeData: causeData);
      },
    );
  }

  void showResolvePopup(
      BuildContext context, Map<String, dynamic> resolutionData) {
    // Define this function to show the resolve popup
    if (ResolvePopup == null) {
      // Handle the case where no cause data is available
      print('Cause data is null.');
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResolvePopup(resolutionData: resolutionData);
      },
    );
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
                rows: reports.map(
                  (report) {
                    return DataRow(
                      cells: [
                        DataCell(Text(report['lineName'] ?? '')),
                        DataCell(Text(report['date'] ?? '')),
                        DataCell(Text(report['technician'] ?? 'No Name')),
                        DataCell(
                          SmallButtons(
                            onTap: () {
                              if (report['cause'] != null &&
                                  report['cause'] is List &&
                                  report['cause'].isNotEmpty) {
                                // Pass the first item in the cause list
                                showCausePopup(context, report['cause'][0]);
                              } else {
                                // Handle cases where cause is null or empty
                                print('No cause data available.');
                              }
                            },
                            buttonText: 'View',
                            buttonColor: GmcColors().teal,
                          ),
                        ),

                        DataCell(
                          SmallButtons(
                            onTap: () {
                              showResolvePopup(
                                  context, report['resolution'][0]);
                            },
                            buttonText: 'View',
                            buttonColor: GmcColors().orange,
                          ),
                        ),
                        DataCell(
                          Text(
                            report['totalDownTime'] ?? 'DOWN',
                          ),
                        ), // Replace with actual downtime
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          );
  }
}
