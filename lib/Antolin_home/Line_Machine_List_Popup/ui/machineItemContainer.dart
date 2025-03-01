import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/container_Ui/lineMachinePopupButtons.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/container_Ui/machineNameCon.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/container_Ui/machinePopupDetails.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/container_Ui/machineStatus.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/container_Ui/tooltipIcons.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/timerContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MachineItemContainer extends StatelessWidget {
  final String machineImage;
  final bool isOnline;
  final String machineName;
  final String operationNumber;
  final String output;
  final String scrap;
  final String rework;
  final Function() maintenanceTap;
  final Function() reportTap;
  final Function() detailsTap;
  const MachineItemContainer(
      {super.key,
      required this.isOnline,
      required this.machineImage,
      required this.machineName,
      required this.operationNumber,
      required this.output,
      required this.scrap,
      required this.rework,
      required this.maintenanceTap,
      required this.reportTap,
      required this.detailsTap});

  Widget _buildDowntimeDisplay() {
    // Only run StreamBuilder when line is offline
    if (!isOnline) {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('downtime')
            .where('lineId', isEqualTo: '7uiqZnLD4iu5wRLzabpe')
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('00:00',
                style: GoogleFonts.inter(
                    color: Colors.green, fontWeight: FontWeight.w500));
          }

          final downtimeDoc = snapshot.data!.docs.first;
          final startTime = (downtimeDoc['startTime'] as Timestamp).toDate();
          final now = DateTime.now();
          final difference = now.difference(startTime);

          final minutes = difference.inMinutes;
          final seconds = difference.inSeconds % 60;
          final formattedTime =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

          // Update Firestore since line is offline
          FirebaseFirestore.instance
              .collection('downtime')
              .doc(downtimeDoc.id)
              .update({
            'endTime': Timestamp.now(),
            'duration': difference.inSeconds,
          });

          return Text(
            formattedTime,
            style: GoogleFonts.inter(
                color: Colors.red, fontWeight: FontWeight.w500),
          );
        },
      );
    } else {
      // When online, just display the stored duration
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('downtime')
            .where('lineId', isEqualTo: '7uiqZnLD4iu5wRLzabpe')
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('00:00',
                style: GoogleFonts.inter(
                    color: Colors.green, fontWeight: FontWeight.w500));
          }

          final downtimeDoc = snapshot.data!.docs.first;
          final duration = downtimeDoc['duration'] as int;
          final minutes = duration ~/ 60;
          final seconds = duration % 60;
          final formattedTime =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

          return Text(
            formattedTime,
            style: GoogleFonts.inter(
                color: Colors.green, fontWeight: FontWeight.w500),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 254,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(234, 234, 234, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              offset: Offset(3, 3),
              color: Color.fromARGB(255, 153, 153, 153),
              blurRadius: 2)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 234,
              width: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(machineImage),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MachineStatus(isOnline: isOnline),
                  const Spacer(),
                  Visibility(
                    visible: isOnline == false,
                    child: TimerContainer(
                      startTime: DateTime.now(),
                      isOffline: true,
                      lineID: '',
                    ),
                  ),
                  MachineNameCon(
                    machineName: machineName,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 290,
              height: 234,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        operationNumber,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Spacer(),
                      const TooltipIcons(iconType: 'maintenance'),
                      const SizedBox(
                        width: 10,
                      ),
                      const TooltipIcons(iconType: 'faultyPart')
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: 3,
                      width: 290,
                      color: GmcColors().antolinBlack,
                    ),
                  ),
                  Container(
                    width: 290,
                    height: 150,
                    decoration: BoxDecoration(
                      color: GmcColors().antolinBlack,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MachinePopupDetails(
                            iconImage: 'images/inputIcon.png',
                            detailName: 'OUTPUT :',
                            child: Text(
                              output,
                              style: GoogleFonts.inter(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          MachinePopupDetails(
                            iconImage: 'images/waveICON.png',
                            detailName: 'SCRAP :',
                            child: Text(
                              scrap,
                              style: GoogleFonts.inter(
                                  color: GmcColors().red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          MachinePopupDetails(
                            iconImage: 'images/waveIcon.png',
                            detailName: 'REWORK :',
                            child: Text(
                              rework,
                              style: GoogleFonts.inter(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          MachinePopupDetails(
                            iconImage: 'images/clockIcon.png',
                            detailName: 'DOWN TIME :',
                            child: _buildDowntimeDisplay(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TO DO ADD ROUTES
                      LineMachinePopupButtons(
                        buttonText: 'MAINTENANCE',
                        onTap: maintenanceTap,
                      ),
                      LineMachinePopupButtons(
                        buttonText: 'SHYFT REPORT',
                        onTap: reportTap,
                      ),
                      LineMachinePopupButtons(
                        buttonText: 'DETAILS',
                        onTap: detailsTap,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
