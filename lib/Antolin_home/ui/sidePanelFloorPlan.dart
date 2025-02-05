import 'package:flutter/material.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/gmcColors.dart';

class SidePanelFloorPlan extends StatefulWidget {
  final String status;
  const SidePanelFloorPlan({super.key, required this.status});

  @override
  State<SidePanelFloorPlan> createState() => _SidePanelFloorPlanState();
}

class _SidePanelFloorPlanState extends State<SidePanelFloorPlan> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.77,
      child: Container(
        height: 520,
        width: 950,
        decoration: BoxDecoration(
          color: GmcColors().antolinBlack,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage('images/mainPlaceholder.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width:
                  //1280 SCREENS
                  MyUtility(context).width == 1280
                      ? 442
                      //1366 SCREENS
                      : MyUtility(context).width == 1366
                          ? 424
                          : 90,
            ),
            Column(
              children: [
                SizedBox(
                  height:
                      //1280 SCREENS
                      MyUtility(context).width == 1280
                          ? 320
                          //1366 SCREENS
                          : MyUtility(context).width == 1366
                              ? 307
                              : 80,
                ),
                Container(
                  height:
                      //1280 SCREENS
                      MyUtility(context).width == 1280
                          ? 52
                          //1366 SCREENS
                          : MyUtility(context).width == 1366
                              ? 50
                              : 50,
                  width:
                      //1280 SCREENS
                      MyUtility(context).width == 1280
                          ? 89
                          //1366 SCREENS
                          : MyUtility(context).width == 1366
                              ? 85
                              : 85,
                  decoration: BoxDecoration(
                    color: widget.status == 'offline'
                        ? GmcColors().red
                        : widget.status == 'maintenance'
                            ? GmcColors().antolinOrange
                            : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Image.asset(
                        'images/demoIcon.png',
                        height: 18,
                      ),
                      Text(
                        'OP 30.2\nPress Right',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
