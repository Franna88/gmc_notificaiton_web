import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/ui/graphPlaceholders.dart';
import 'package:gmcweb/Antolin_home/ui/homeMetrixContainers.dart';
import 'package:gmcweb/Antolin_home/ui/sidePanelFloorPlan.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/myutility.dart';

class AntolinMain extends StatefulWidget {
  const AntolinMain({super.key});

  @override
  State<AntolinMain> createState() => _AntolinMainState();
}

class _AntolinMainState extends State<AntolinMain> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width - 80,
      height: MyUtility(context).height - 65,
      child: Column(
        children: [
          Container(
            height: 55,
            width: MyUtility(context).width - 80,
            color: GmcColors().antolinBlack,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 3),
                  child: Container(
                    height: 44,
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          GmcColors().antolinTeal,
                          const Color.fromRGBO(16, 90, 71, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'SIDE PANELS',
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              //
              //ORDER QTY
              //
              HomeMetrixContainers(
                header: 'Order Qty',
                //customWidth: MyUtility(context).width * 0.28 - 155,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '320 000',
                        style: GoogleFonts.inter(
                            color: GmcColors().antolinTeal,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                      Text(
                        'UNITS',
                        style: GoogleFonts.inter(
                            letterSpacing: 1.4,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                    ],
                  ),
                ),
              ),
              //
              //TOTAL OUT
              //
              const SizedBox(
                width: 15,
              ),
              HomeMetrixContainers(
                header: 'Order Qty',
                //customWidth: MyUtility(context).width * 0.28 - 155,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '320 000',
                        style: GoogleFonts.inter(
                            color: GmcColors().antolinTeal,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                      Text(
                        'UNITS',
                        style: GoogleFonts.inter(
                            letterSpacing: 1.4,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                    ],
                  ),
                ),
              ),
              //
              //TOTAL WASTE
              //
              const SizedBox(
                width: 15,
              ),
              HomeMetrixContainers(
                header: 'Order Qty',
                //customWidth: MyUtility(context).width * 0.28 - 155,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '320 000',
                        style: GoogleFonts.inter(
                            color: GmcColors().antolinTeal,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                      Text(
                        'UNITS',
                        style: GoogleFonts.inter(
                            letterSpacing: 1.4,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                    ],
                  ),
                ),
              ),
              //
              //BATCH NUMBER
              //
              const SizedBox(
                width: 15,
              ),
              HomeMetrixContainers(
                header: 'Order Qty',
                // customWidth: MyUtility(context).width * 0.28 - 155,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '320 000',
                        style: GoogleFonts.inter(
                            color: GmcColors().antolinTeal,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                      Text(
                        'UNITS',
                        style: GoogleFonts.inter(
                            letterSpacing: 1.4,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                    ],
                  ),
                ),
              ),

              //
              //TARGET
              //
              const SizedBox(
                width: 15,
              ),
              HomeMetrixContainers(
                header: 'Order Qty',
                //customWidth: MyUtility(context).width * 0.28 - 155,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '320 000',
                        style: GoogleFonts.inter(
                            color: GmcColors().antolinTeal,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                      Text(
                        'UNITS',
                        style: GoogleFonts.inter(
                            letterSpacing: 1.4,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    GraphPlaceholders(),
                    SizedBox(
                      height: 15,
                    ),
                    GraphPlaceholders(),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                SidePanelFloorPlan(
                  status: 'offline',
                ),
                SizedBox(
                  width: 14,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
