import 'package:flutter/material.dart';
import 'package:gmcweb/CommonUi/details_reusable_container.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsReadings extends StatelessWidget {
  const DetailsReadings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'images/details.png',
              width: MyUtility(context).width * 0.22,
              height: MyUtility(context).height * 0.6,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MyUtility(context).width * 0.2,
                  height: MyUtility(context).height * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: GmcColors().antolinBlack),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '1600 Ton Press',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MyUtility(context).width * 0.26,
                  height: MyUtility(context).height * 0.26,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: GmcColors().antolinBlack),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Metrics',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Evenly spaces remaining texts
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns text to the left
                            children: [
                              DetailsReusableContainer(
                                  icon: 'images/force.png',
                                  text: 'Press Force',
                                  amount: '1550',
                                  calculationOne: ' T'),
                              DetailsReusableContainer(
                                  icon: 'images/rate.png',
                                  text: 'Stroke Rate',
                                  amount: '25',
                                  calculationOne: ' CPM'),
                              DetailsReusableContainer(
                                  icon: 'images/position.png',
                                  text: 'Stroke Position',
                                  amount: '85',
                                  calculationOne: ' %'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MyUtility(context).width * 0.26,
                  height: MyUtility(context).height * 0.26,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: GmcColors().antolinBlack),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Metrics',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          child: Divider(
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Evenly spaces remaining texts
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns text to the left
                            children: [
                              DetailsReusableContainer(
                                  icon: 'images/force.png',
                                  text: 'Current Cycles',
                                  amount: '12345',
                                  calculationOne: ' T'),
                              DetailsReusableContainer(
                                  icon: 'images/rate.png',
                                  text: 'Average Cycle',
                                  amount: '80',
                                  calculationOne: ' CPM'),
                              DetailsReusableContainer(
                                  icon: 'images/position.png',
                                  text: 'Maintenance Due',
                                  amount: '85',
                                  calculationOne: ' %'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              width: MyUtility(context).width * 0.5,
              height: MyUtility(context).height * 0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: GmcColors().antolinBlack),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Evenly spaces remaining texts
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Aligns text to the left
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MyUtility(context).width * 0.2,
                                height: MyUtility(context).height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.warning_amber_outlined),
                                      Spacer(),
                                      Text(
                                        'Warning High Stroke Rate',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MyUtility(context).width * 0.15,
                                height: MyUtility(context).height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '14 JAN, TUE',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        color: Colors.black,
                                        width: MyUtility(context).width * 0.05,
                                        height:
                                            MyUtility(context).height * 0.035,
                                        child: Center(
                                          child: Text(
                                            '12 : 00 AM',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MyUtility(context).width * 0.2,
                                height: MyUtility(context).height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.warning_amber_outlined),
                                      Spacer(),
                                      Text(
                                        'Warning High Stroke Rate',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MyUtility(context).width * 0.15,
                                height: MyUtility(context).height * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '14 JAN, TUE',
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        color: Colors.black,
                                        width: MyUtility(context).width * 0.05,
                                        height:
                                            MyUtility(context).height * 0.035,
                                        child: Center(
                                          child: Text(
                                            '12 : 00 AM',
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
