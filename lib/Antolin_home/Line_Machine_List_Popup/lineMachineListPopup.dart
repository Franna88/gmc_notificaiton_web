import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/machineItemContainer.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/popupLineHeader.dart';
import 'package:gmcweb/Antolin_home/Shyft_Report/shyftReport.dart';
import 'package:gmcweb/Antolin_home/ui/DetailsPage/details_page.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/maintenance_page.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LineMachineListPopup extends StatefulWidget {
  final Function(int, Widget) navigateToPage;
  const LineMachineListPopup({super.key, required this.navigateToPage});

  @override
  State<LineMachineListPopup> createState() => _LineMachineListPopupState();
}

class _LineMachineListPopupState extends State<LineMachineListPopup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 525,
        height: MyUtility(context).height - 120,
        color: Colors.white,
        child: Column(
          children: [
            const PopupLineHeader(
                line: 'Line 1', operation: 'Injection Moulding'),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('production')
                  .orderBy('timestamp', descending: true)
                  .limit(1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final totalOut =
                    snapshot.data?.docs.first.get('totalOut')?.toString() ??
                        '0';
                return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('systems')
                        .doc('7uiqZnLD4iu5wRLzabpe')
                        .snapshots(),
                    builder: (context, systemSnapshot) {
                      bool isOnline = false;
                      if (systemSnapshot.hasData &&
                          systemSnapshot.data!.exists) {
                        // Get the online status directly from the document
                        isOnline = systemSnapshot.data!.get('online') ?? false;
                      }

                      return MachineItemContainer(
                        isOnline: isOnline,
                        machineImage: 'images/dummyImage.png',
                        machineName: '1600 Ton Press',
                        operationNumber: 'OP 10.1',
                        output: totalOut,
                        scrap: '34',
                        rework: '11',
                        maintenanceTap: () {
                          Navigator.of(context).pop();
                          widget.navigateToPage(3, const MaintenancePage());
                        },
                        reportTap: () {
                          Navigator.of(context).pop();
                          widget.navigateToPage(5, const ShyftReport());
                        },
                        detailsTap: () {
                          Navigator.of(context).pop();
                          widget.navigateToPage(4, const DetailsPage());
                        },
                      );
                    });
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
