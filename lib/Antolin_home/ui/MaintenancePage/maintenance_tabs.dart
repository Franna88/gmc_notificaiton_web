import 'package:flutter/material.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/reusable_attending_profile_container.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/reusable_containers_with_headers.dart';
import 'package:gmcweb/Antolin_home/ui/MaintenancePage/reusable_small_grey_container.dart';
import 'package:gmcweb/CommonUi/details_reusable_container.dart';
import 'package:gmcweb/Constants/gmcColors.dart';
import 'package:gmcweb/Constants/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceTabs extends StatelessWidget {
  const MaintenanceTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MyUtility(context).height,
      width: MyUtility(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              color: GmcColors().antolinBlack,
              height: MyUtility(context).height * 0.05,
              width: MyUtility(context).width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 35,
                          width: 350,
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
                              'CURRENT MAINTENANCE',
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MyUtility(context).height * 0.48,
            width: MyUtility(context).width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: GmcColors().antolinBlack),
                color: GmcColors().lightGrey),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ReusableSmallGreyContainer(
                          width: MyUtility(context).width * 0.06,
                          customText: 'SHIFT',
                          whiteContents: '1'),
                      const SizedBox(width: 20),
                      ReusableSmallGreyContainer(
                        width: MyUtility(context).width * 0.14,
                        customText: 'DOWNTIME',
                        whiteContents: '19 : 00',
                        addIcon: true,
                      ),
                      const Spacer(),
                      ReusableSmallGreyContainer(
                        width: MyUtility(context).width * 0.12,
                        customText: '14 JAN, TUE',
                        whiteContents: '12 : 00 AM',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ReusableContainersWithHeaders(
                        customText: 'Cell 5',
                        customWidth: MyUtility(context).width * 0.3,
                        containerContents: Column(
                          children: [
                            Image.asset('images/current_maintenace.png',
                                fit: BoxFit.contain,
                                width: MyUtility(context).width * 0.12,
                                height: MyUtility(context).width * 0.12),
                            Text(
                              'Vibration detected Motor faulty',
                              style: GoogleFonts.poppins(
                                color: GmcColors().antolinBlack,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      ReusableContainersWithHeaders(
                        customText: 'Attending Crew',
                        customWidth: MyUtility(context).width * 0.5,
                        containerContents: const Wrap(
                          children: [
                            ReusableAttendingProfileContainer(
                                name: 'Alec Whitten',
                                jobDescription: 'Production Manager'),
                            ReusableAttendingProfileContainer(
                                name: 'Youssef Robertson',
                                jobDescription: 'Floor Manager'),
                            ReusableAttendingProfileContainer(
                                name: 'Ammar Foulie',
                                jobDescription: 'Maintenance Crew'),
                            ReusableAttendingProfileContainer(
                                name: 'Sam Jens',
                                jobDescription: 'Maintenance Crew')
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
