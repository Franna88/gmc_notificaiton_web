import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/timerContainer.dart';
import 'package:gmcweb/Reports/ReportsPopUps/cause_popup.dart';
import 'package:gmcweb/Reports/ReportsPopUps/resolve_popup.dart';
import 'package:gmcweb/Users/UserTable/ui/tableStructure.dart';

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
      final List<Map<String, dynamic>> fetchedReports =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'lineID': data['lineId'],
          'date': data['timestamp'],
          'technician': data['technicianName'],
          'cause': data['cause'],
          'status': data['status'],
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

  // void showCausePopup(Map<String, dynamic> causeData) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: Container(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Image.network(causeData['imageUrl']),
  //               const SizedBox(height: 16),
  //               Text(causeData['description'],
  //                   style: const TextStyle(fontSize: 16)),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void showCausePopup(BuildContext context, Map<String, dynamic> causeData) {
    showDialog(
      context: context,
      builder: (context) {
        return CausePopup(causeData: causeData);
      },
    );
  }

  void showResolvePopup(
      BuildContext context, Map<String, dynamic> resolutionData) {
    showDialog(
      context: context,
      builder: (context) {
        return ResolvePopup(resolutionData: resolutionData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            height: MyUtility(context).height - 205,
            width: MyUtility(context).width - 340,
            decoration: BoxDecoration(
                border: Border.all(color: GmcColors().black),
                color: GmcColors().lightGrey),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: GmcColors().black),
                  children: [
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Line ID',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Technician',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Cause',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Resolved',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    TableStructure(
                      child: const TableCell(
                        child: Text(
                          'Downtime',
                          style: TextStyle(
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
                    final report = reports[index];
                    return TableRow(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.grey.shade200
                            : Colors.white,
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
                              report['lineID'] ?? '',
                              style: const TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        TableStructure(
                          child: TableCell(
                            child: Text(
                              //report['date'] ?? '',
                              'Date here',
                              style: const TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        TableStructure(
                          child: TableCell(
                            child: Text(
                              report['technicianId'] ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TableStructure(
                          child: TableCell(
                            child: SmallButtons(
                              onTap: () {
                                showCausePopup(
                                  context,
                                  report['cause'][0],
                                ); // Pass the first cause
                              },
                              buttonText: 'View',
                              buttonColor: GmcColors().teal,
                            ),
                          ),
                        ),
                        TableStructure(
                          child: TableCell(
                            child: SmallButtons(
                              onTap: () {
                                showResolvePopup(
                                  context,
                                  report['resolution'][0],
                                ); // Pass the first resolution
                              },
                              buttonText: 'View',
                              buttonColor: GmcColors().orange,
                            ),
                          ),
                        ),
                        TableStructure(
                          child: TableCell(
                            child: TimerContainer(isOffline: true),
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
