import 'package:flutter/material.dart';
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
              widget.lineID,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: widget.isOffline,
              child: UserIconContainer(userName: 'User Name'),
            ),
            const SizedBox(
              width: 30,
            ),
            Visibility(
              visible: widget.isOffline,
              child: TimerContainer(isOffline: widget.isOffline),
            ),
            const SizedBox(
              width: 50,
            ),
            LineStatus(isOffline: widget.isOffline)
          ],
        ),
      ),
    );
  }
}
