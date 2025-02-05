import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/machineItemContainer.dart';
import 'package:gmcweb/Antolin_home/Line_Machine_List_Popup/ui/popupLineHeader.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class LineMachineListPopup extends StatefulWidget {
  const LineMachineListPopup({super.key});

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
            PopupLineHeader(line: 'Line 1', operation: 'Injection Moulding'),
            const SizedBox(
              height: 20,
            ),
            MachineItemContainer(
              isOnline: true,
              machineImage: 'images/dummyImage.png',
              machineName: '1600 Ton Press',
              operationNumber: 'OP 10.1',
              input: '5700',
              scrap: '34',
              rework: '11',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
