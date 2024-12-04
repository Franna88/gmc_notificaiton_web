import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/smallButtons.dart';
import 'package:gmcweb/CommonUi/stackedHeaders.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:gmcweb/Lines/ui/LineContainers/lineContainer.dart';
import 'package:gmcweb/Lines/ui/newLinePopup.dart';
import 'package:google_fonts/google_fonts.dart';

class LinesMain extends StatefulWidget {
  const LinesMain({super.key});

  @override
  State<LinesMain> createState() => _LinesMainState();
}

class _LinesMainState extends State<LinesMain> {

   Future openNewLinePopup() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: NewLinePopup(),
        );
      });



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width - 280,
      height: MyUtility(context).height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            StackedHeaders(constrianedWidth: 450, width: 445, header: 'Lines'),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SmallButtons(
                onTap: openNewLinePopup,
                buttonText: 'Add Line',
                buttonColor: GmcColors().teal,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MyUtility(context).width - 360,
              height: 50,
              color: GmcColors().black,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 50),
                child: Row(
                  children: [
                    Text(
                      'Line ID',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                      ),
                    ),
                    const Spacer(),
                     Text(
                      'Status',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            LineContainer(isOffline: true, lineID: 'AG5J85D')
          ],
        ),
      ),
    );
  }
}
