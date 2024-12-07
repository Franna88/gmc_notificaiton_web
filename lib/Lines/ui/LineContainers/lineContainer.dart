import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/lineStatus.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/timerContainer.dart';
import 'package:gmcweb/Lines/ui/LineContainers/ui/userIconContainer.dart';
import 'package:google_fonts/google_fonts.dart';

class LineContainer extends StatefulWidget {
  final bool isOffline;
  final String lineID;

  const LineContainer(
      {super.key, required this.isOffline, required this.lineID});

  @override
  State<LineContainer> createState() => _LineContainerState();
}

class _LineContainerState extends State<LineContainer> {
  String? technicianName;
  String? lineName;
  bool isLoading = true;

  Future<void> fetchLineDetails() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('systems')
          .doc(widget.lineID)
          .get();

      if (docSnapshot.exists) {
        setState(() {
          lineName = docSnapshot['line_Name'] ?? 'No Name';
          technicianName = docSnapshot['technicianName'] ?? 'No Name';
          isLoading = false; // Mark loading as complete
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching line details: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLineDetails();
    print('***this is $technicianName');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MyUtility(context).width - 80,
      decoration: BoxDecoration(
        color: GmcColors().lightGrey,
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              //widget.lineID,
              lineName ?? 'No Name',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: widget.isOffline && !isLoading,
              child: UserIconContainer(
                userName: technicianName ?? 'No Technician',
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Visibility(
              visible: widget.isOffline,
              child: TimerContainer(
                  startTime: isLoading ? null : DateTime.now(),
                  isOffline: widget.isOffline),
            ),
            const SizedBox(
              width: 50,
            ),
            LineStatus(isOffline: widget.isOffline),
          ],
        ),
      ),
    );
  }
}
